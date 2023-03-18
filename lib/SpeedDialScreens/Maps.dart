import 'package:flutter/material.dart';

class Mlocate extends StatefulWidget {
  const Mlocate({Key? key}) : super(key: key);

  @override
  State<Mlocate> createState() => _MlocateState();
}

class _MlocateState extends State<Mlocate> {
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
