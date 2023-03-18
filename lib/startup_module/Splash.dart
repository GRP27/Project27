import 'dart:async';
import 'package:flutter/material.dart';

import 'package:proj27/login_module/LoginPage.dart';
import 'package:proj27/main_module/HomePage.dart';
import 'package:proj27/provider/sign_in_provider.dart';
import 'package:proj27/utils/next_screen.dart';
import 'package:provider/provider.dart';

class SlashC extends StatefulWidget {
  const SlashC({Key? key}) : super(key: key);
  @override
  State<SlashC> createState() => _SlashCState();
}
class _SlashCState extends State<SlashC> {

  @override
  void initState(){
    final sp = context.read<SignInProvider>();
    super.initState();

    Timer(const Duration(seconds: 2), (){
      sp.isSignedIn == false
          ? nextScreen(context, const LoginP())
          : nextScreen(context, const HomePage());
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/backg.jpg'),
              fit: BoxFit.cover
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/logo1.png',
                  width: size.width,
                  height: size.height * 0.9,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
