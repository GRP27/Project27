import 'package:flutter/material.dart';

class Econtact extends StatefulWidget {
  const Econtact({Key? key}) : super(key: key);

  @override
  State<Econtact> createState() => _EcontactState();
}

class _EcontactState extends State<Econtact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: const Text(
            'MAPS PAGE',
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
        ),
      ),
    );
  }
}
