import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class PositionServices{
  final String API_KEY = 'AIzaSyBL1NxQ4STp0GC-CUAQxO37ZsNw-w3300M';
  final String baseUrl = 'https://maps.googleapis.com/maps/api/place';

  Future<String> getPlaceId(String searchInput) async {
    final String url = '$baseUrl/findplacefromtext/json?input=$searchInput&inputtype=textquery&key=$API_KEY';

    var response = await http.get(Uri.parse(url));
    var jsonResponse = jsonDecode(response.body);
    var placeId = jsonResponse['candidates'][0]['place_id'] as String;
    return placeId;
  }
  Future<Map<String, dynamic>> getPlaceDetails(String place) async {
    final placeId = await getPlaceId(place);
    final String url = "$baseUrl/details/json?place_id=$placeId&key=$API_KEY";
    var response = await http.get(Uri.parse(url));
    var jsonResponse = jsonDecode(response.body);
    var placeDetails = jsonResponse['result'] as Map<String, dynamic>;
    return placeDetails;
  }

Future<Map<String, dynamic>> getRoutes(String origin, String destination) async {
 final url = "https://maps.googleapis.com/maps/api/directions/json?destination=$destination&origin=$origin&key=$API_KEY";
 var response = await http.get(Uri.parse(url));
 var jsonResponse = jsonDecode(response.body);
 var routeDetails = {
   'bound_northeast':jsonResponse['routes'][0]['bounds']['northeast'],
   'bound_southeast':jsonResponse['routes'][0]['bounds']['southeast'],
   'start_location':jsonResponse['routes'][0]['legs'][0]['start_location'],
   'end_location':jsonResponse['routes'][0]['legs'][0]['end_location'],
   'polyline':jsonResponse['routes'][0]['overview_polyline']['points'],
   'polyline_points': PolylinePoints().decodePolyline(jsonResponse['routes'][0]['overview_polyline']['points']),
 };
 return routeDetails;
}
Future<Position> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {

    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {

      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {

    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}
}