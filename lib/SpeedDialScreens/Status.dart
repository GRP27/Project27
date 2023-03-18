import 'package:flutter/material.dart';

class Stat extends StatefulWidget {
  const Stat({Key? key}) : super(key: key);

  @override
  State<Stat> createState() => _StatState();
}

class _StatState extends State<Stat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: const Text(
            'STATUS PAGE',
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
