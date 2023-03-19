import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj27/FireDeptMod/FireDpt.dart';
import 'package:proj27/GoogleMapModules/mapz.dart';
import 'package:proj27/HospitalMod/Hospitals.dart';
import 'package:proj27/PersonalizationP/PersP.dart';
import 'package:proj27/PoliceDeptMod/PoilceSt.dart';
import 'package:proj27/SpeedDialScreens/EmergencyContacts.dart';
import 'package:proj27/SpeedDialScreens/Maps.dart';
import 'package:proj27/SpeedDialScreens/Status.dart';
import 'package:proj27/provider/sign_in_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final sp = context.read<SignInProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        openCloseDial: isDialOpen,
        backgroundColor: Colors.pink,
        overlayColor: Colors.grey,
        overlayOpacity: 0.5,
        spacing: 10,
        spaceBetweenChildren: 10,
        closeManually: false,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.fire_truck_rounded),
              label: 'Status',
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Stat()));
              }
          ),
          SpeedDialChild(
              child: const Icon(Icons.map),
              label: 'Map',
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Mlocate()));
              }
          ),
          SpeedDialChild(
              child: const Icon(Icons.contact_emergency_outlined),
              label: 'Emergency',
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Econtact()));
              }
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 180),
                    child: Text(
                      "FirstToAid",
                      style: GoogleFonts.pacifico(
                          fontSize: 30,
                          color: Colors.pink,
                          fontWeight: FontWeight.w100
                      ),
                    ),
                  ),
                  InkWell(
                    splashColor: const Color(0xffffebee),
                    child: const Icon(
                      Icons.account_circle,
                      color: Colors.pink,
                      size: 50,
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PersP()));
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Card(
                  color: Colors.white24,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Colors.purple[50],
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MapSample()));
                    },
                    child: SizedBox(
                        height: size.height/4,
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, top: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Quick',
                                style: GoogleFonts.poppins(
                                  color: Colors.pink,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                              Text('Search!',
                                style: GoogleFonts.poppins(
                                    color: Colors.pink,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              Text('Tap here',
                                style: GoogleFonts.poppins(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Divider(
                      indent: 20.0,
                      endIndent: 10.0,
                      thickness: 1.5,
                      color: Colors.black26,
                    ),
                  ),
                  Text(
                      "Services",
                      style: GoogleFonts.mulish(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 20
                      )
                  ),
                  const Expanded(
                    child: Divider(
                      indent: 10.0,
                      endIndent: 20.0,
                      thickness: 1.5,
                      color: Colors.black26,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HospM()));
                  },
                  child: Card(
                    color: Colors.white10,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Wrap(
                      children: [
                        Container(
                          width: size.width,
                          height: size.height/4,
                          decoration: BoxDecoration(
                            image: const DecorationImage(image:
                            NetworkImage('https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?ix'
                                'lib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=forma'
                                't&fit=crop&w=1453&q=80'),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Hospitals/Clinics",
                              style: GoogleFonts.mulish(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87
                              ),
                            ),
                            const SizedBox(width: 5,),
                            const Padding(
                              padding: EdgeInsets.only(right: 18),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FireDpt()));
                  },
                  child: Card(
                    color: Colors.white10,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Wrap(
                      children: [
                        Container(
                          width: size.width,
                          height: size.height/4,
                          decoration: BoxDecoration(
                            image: const DecorationImage(image:
                            NetworkImage('https://scontent.fbom20-2.fna.fbcdn.net/v/t39.30808-6/279149157_34906630'
                                '3920648_4689195379222178607_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=-xpOZBAT'
                                'mQsAX-XBhOJ&_nc_ht=scontent.fb'
                                'om20-2.fna&oh=00_AfAkqQqAAyoAoz4tEHZ1QPrdSE9xqLNP39zsFYIeLwLL4g&oe=641983E5'),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Fire Dept.",
                              style: GoogleFonts.mulish(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87
                              ),
                            ),
                            const SizedBox(width: 5,),
                            const Padding(
                              padding: EdgeInsets.only(right: 18),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PolSt()));
                  },
                  child: Card(
                    color: Colors.white10,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Wrap(
                      children: [
                        Container(
                          width: size.width,
                          height: size.height/4,
                          decoration: BoxDecoration(
                            image: const DecorationImage(image:
                            NetworkImage('https://cdn.dnaindia.com/sites/default/files/styles/full/public/2020/05/16/906280-mumbai-police-4.jpg'),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Police Dept.",
                              style: GoogleFonts.mulish(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87
                              ),
                            ),
                            const SizedBox(width: 5,),
                            const Padding(
                              padding: EdgeInsets.only(right: 18),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AnimatedTextKit(
                        animatedTexts: [
                          FadeAnimatedText('Your', textStyle: const TextStyle(fontSize: 70, color: Colors.purple)),
                          FadeAnimatedText('Life', textStyle: const TextStyle(fontSize: 70, color: Colors.purple)),
                          FadeAnimatedText('Matters!', textStyle: const TextStyle(fontSize: 70, color: Colors.purple))
                        ],
                        isRepeatingAnimation: true,
                      ),
                      const SizedBox(height: 80,)
                    ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.map,
    Icons.fire_truck_rounded,
    Icons.quick_contacts_dialer_sharp
  ];

  List<String> listOfStrings = [
    'Home',
    'Map',
    'Status',
    'Contacts',
  ];
}
