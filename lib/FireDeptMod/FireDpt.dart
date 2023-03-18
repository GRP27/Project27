import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FireDpt extends StatefulWidget {
  const FireDpt({Key? key}) : super(key: key);

  @override
  State<FireDpt> createState() => _FireDptState();
}

class _FireDptState extends State<FireDpt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 30),
              child: Row(
                children: [
                  Text('Fire Dept.',
                    style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.w100,
                      color: Colors.black87,
                      fontSize: 50,
                    ),
                  ),
                  const SizedBox(width: 100,),
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 40,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
