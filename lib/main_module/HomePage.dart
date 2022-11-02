import 'package:flutter/material.dart';
import 'package:proj27/login_module/LoginPage.dart';
import 'package:proj27/provider/sign_in_provider.dart';
import 'package:proj27/utils/next_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final sp = context.read<SignInProvider>();
    return Scaffold(
      body: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Akshat Ovalekar",
                      style: TextStyle(
                        fontSize: 30
                      ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    sp.userSignOut();
                    nextScreenReplaced(context, const LoginP());
                  },
                  child: const Text("Sign Out",
                    style: TextStyle(
                        fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
