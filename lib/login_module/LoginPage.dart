
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:proj27/login_module/PhoneAuth.dart';
import 'package:proj27/main_module/HomePage.dart';
import 'package:proj27/provider/internet_provider.dart';
import 'package:proj27/provider/sign_in_provider.dart';
import 'package:proj27/utils/next_screen.dart';
import 'package:proj27/utils/snackBar.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginP extends StatefulWidget {
  const LoginP({Key? key}) : super(key: key);

  @override
  State<LoginP> createState() => _LoginPState();
}

class _LoginPState extends State<LoginP> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  final RoundedLoadingButtonController googleController = RoundedLoadingButtonController();
  final RoundedLoadingButtonController phoneController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffffebee),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height/ 2.2,
              width:  size.width,
              child: Lottie.asset('assets/2.json'),
            ),
            const Text("Login using",
              style: TextStyle(
                fontSize: 28,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 95, right: 95),
              child: RoundedLoadingButton(
                  borderRadius: 50,
                  controller: googleController,
                  onPressed: (){
                    nextScreenReplaced(context, const PhoneAuthScreen());
                    phoneController.reset();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10,),
                        Icon(
                          FontAwesomeIcons.phone,
                          size: 20,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding:  EdgeInsets.only(left: 20),
                          child: Text("Sign in with Phone",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 190),
              child: SizedBox(
                height:20,
                child: Row(
                  children: const [
                    Text("- OR -"),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 95, right: 95),
              child: RoundedLoadingButton(
                borderRadius: 50,
                  controller: googleController,
                  onPressed: (){
                  handleGoogleSignIn();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset('assets/google.png'),
                        const Padding(
                          padding:  EdgeInsets.only(left: 20),
                          child: Text("Sign in with Google",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

  Future handleGoogleSignIn() async {
   final sp = context.read <SignInProvider>();
   final ip = context.read<InternetProvider>();
   await ip.checkInternetConnection();
   if(ip.hasInternet == false){
     openSnackBar(context, "Check your Internet Connection", Colors.red);
     googleController.reset();
   } else {
     await sp.signInWithGoogle().then((value) {
       if(sp.hasError == true){
         openSnackBar(context, sp.errorCode.toString() , Colors.red);
         googleController.reset();
       }
       else {
         //Checking if user exists or no
         sp.checkUserExists().then((value) async{
           if(value == true){
             //User exists
             await sp.getUserDataFromFirestore(sp.uid).then((value) => sp.saveDataToSharedPreferences().then((value) => sp.setSignIn().then((value) {
               googleController.success();
               handleAfterSignIn();
             }
             )));
           } else {
             //User does not exist
             sp.saveDataToFirestore().then((value) => sp.saveDataToSharedPreferences().then((value) => sp.setSignIn().then((value) {
               googleController.success();
               handleAfterSignIn();
             })));
           }
         });
       }
     });
   }
  }
  //handle after sign in
handleAfterSignIn(){
    Future.delayed(const Duration(milliseconds: 1000)).then((value){
      nextScreenReplaced(context, const HomePage());
    });
}


}

