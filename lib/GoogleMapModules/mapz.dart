import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proj27/GoogleMapModules/places.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  Set<Marker> _manyMarker = <Marker>{};
  Set<Polyline> _polylines = <Polyline>{};
  Placemark _address = Placemark();

  void _addMarker(LatLng markerPoints){
    setState(() {
      _manyMarker.add(Marker(
        markerId: MarkerId('Marker ${_manyMarker.length}'),
        position: LatLng(markerPoints.latitude, markerPoints.longitude),
        infoWindow: InfoWindow(
            title: _address == null ? 'Position ${_manyMarker.length + 1}' : '${_address.street}',
            snippet: _address == null ? 'lat: ${markerPoints.latitude}, long: ${markerPoints.longitude}':'${_address.street},${_address.postalCode},${_address.administrativeArea},${_address.country}'
        ),
      ));
    });
  }

  void _addRoutePolylines(List<PointLatLng> points) {
    _polylines.add(Polyline(polylineId: PolylineId('Polyline ${_polylines.length + 1}'),
    width: 2,
      color: Colors.pinkAccent,
      points: points.map((point) => LatLng(point.latitude, point.longitude)).toList(),
    ));
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(0, 0),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 210),
        child: FloatingActionButton(
          backgroundColor: Colors.pink,
            onPressed: () async {
            Position currentPosition = await PositionServices().getCurrentLocation();
            _goCurrentPosition(currentPosition.latitude, currentPosition.longitude);
            },
        child: Icon(
          Icons.location_searching_sharp,
          size: 20,
        ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          size: 30,
              color: Colors.white
        ),
        backgroundColor: Colors.pink,
        title: Text('Google Maps'),
        titleTextStyle: TextStyle(
          fontSize: 25,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              markers: _manyMarker,
              polylines: _polylines,
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (position) async {

                List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
                _address = placemarks[0];
                _addMarker(position);
              }
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15,10,15,5),
                child: TextFormField(
                  controller: _originController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      hintText: 'Enter origin',
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white)
                    ),
                    prefixIcon: Icon(
                      Icons.location_pin,
                      color: Colors.pink,
                      size: 25,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15,10,15,5),
                child: TextFormField(
                  controller: _destinationController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    hintText: 'Enter Destination',
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white)
                    ),
                    prefixIcon: Icon(
                      Icons.location_pin,
                      color: Colors.pink,
                      size: 25,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: FilledButton.tonal(
                    onPressed: () async {
                      // final place = await PositionServices().getPlaceDetails(_originController.text);

                     var route =  await PositionServices().getRoutes(_originController.text, _destinationController.text);

                      _goToPlace(route['start_location']['lat'], route['start_location']['lng'],
                          route['end_location']['lat'], route['end_location']['lng'],
                      );

                      _addRoutePolylines(route['polyline_points']);

                    },
                    child: Text('Get Directions',
                    style: TextStyle(
                    fontSize: 18,
                    ),
                    ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.pink),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }

  Future<void> _goCurrentPosition(
      double start_lat,
      double start_long, ) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(start_lat, start_long), zoom:12)));
    _addMarker(LatLng(start_lat, start_long));

  }



  Future<void> _goToPlace(
      double start_lat,
      double start_long,
      double end_lat,
      double end_long,
      ) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(start_lat, start_long), zoom:12)));

    _addMarker(LatLng(start_lat, start_long));
    _addMarker(LatLng(end_lat, end_long));
  }
}