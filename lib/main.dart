import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proj27/login_module/LoginPage.dart';
import 'package:proj27/provider/internet_provider.dart';
import 'package:proj27/provider/sign_in_provider.dart';
import 'package:proj27/startup_module/Splash.dart';

import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignInProvider()),
        ChangeNotifierProvider(create: (context) => InternetProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          'login': (context) => const LoginP(),
          'splash': (context) => const SlashC(),
        },
        initialRoute: 'splash',
      ),
    );
  }
}

