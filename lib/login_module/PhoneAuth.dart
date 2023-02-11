import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:proj27/login_module/LoginPage.dart';
import 'package:proj27/main_module/HomePage.dart';
import 'package:proj27/provider/internet_provider.dart';
import 'package:proj27/provider/sign_in_provider.dart';
import 'package:proj27/utils/next_screen.dart';
import 'package:proj27/utils/snackBar.dart';
import 'package:provider/provider.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final formKey = GlobalKey<FormState>();

  //controllers required for phone authentication
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController OtpCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffffebee),
      appBar: AppBar(
        backgroundColor: Color(0xff3f51b5),
        leading: IconButton(
            onPressed: (){
              nextScreenReplaced(context, const LoginP());
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            SizedBox(
              height: size.height/ 2.2,
              width:  size.width,
              child: Lottie.asset('assets/3.json'),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                children: [
                  Text("Phone Authentication",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty) {
                            return ("Name field cannot be empty!");
                            }
                          return null;
                        },
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.account_circle,
                          ),
                          hintText: "Enter your name",
                          hintStyle: TextStyle(color: Colors.grey),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xff3f51b5)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xff3f51b5)),
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty) {
                            return ("Email address cannot be empty!");
                          }
                          return null;
                        },
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.email,
                            ),
                            hintText: "Enter your email",
                            hintStyle: TextStyle(color: Colors.grey),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xff3f51b5)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xff3f51b5)),
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty) {
                            return ("This field cannot be empty!");
                          }
                          return null;
                        },
                        controller: phoneController,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.phone,
                            ),
                            hintText: "Enter your phone number",
                            hintStyle: TextStyle(color: Colors.grey),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xff3f51b5)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xff3f51b5)),
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Center(
                      child: ElevatedButton(
                          onPressed: (){
                            login(context, phoneController.text.trim());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text("Register",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff3f51b5),
                          elevation: 10,
                        ),
                      ),
                    ),
                    SizedBox(height: 40,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future login(BuildContext context, String mobile) async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if(ip.hasInternet == false){
      openSnackBar(context, "Check your internet connection", Colors.red);
    }
    else {
      if(formKey.currentState!.validate()){
        FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: mobile,
            verificationCompleted: (AuthCredential credential) async {
            await FirebaseAuth.instance.signInWithCredential(credential);
            },
            verificationFailed: (FirebaseAuthException e) {
            openSnackBar(context, e.toString(), Colors.red);
            },
            codeSent: (String verificationId, int? forceResendingToken) {
            showDialog(
              barrierDismissible: false,
                context: context,
                builder: (context){
                  return AlertDialog(
                  title: const Text("Enter OTP Code"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     TextField(
                       controller: OtpCodeController,
                       decoration: InputDecoration(
                         prefixIcon: const Icon(Icons.code),
                         errorBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(8),
                           borderSide: const BorderSide(color: Colors.red),
                         ),
                           focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(8),
                             borderSide: const BorderSide(color: Color(0xff3f51b5)),
                           ),
                           enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(8),
                             borderSide: const BorderSide(color: Color(0xff3f51b5)),
                           )
                       ),
                     ),
                      const SizedBox(height: 10,),
                      ElevatedButton(
                          onPressed: () async {
                            final code = OtpCodeController.text.trim();
                            AuthCredential authCredential = PhoneAuthProvider
                                .credential(
                                verificationId: verificationId,
                                smsCode: code);
                            User user = (await FirebaseAuth.instance
                                .signInWithCredential(authCredential)).user!;
                            sp.phoneNumberUser(user, emailController.text,
                                nameController.text);
                            sp.checkUserExists().then((value) async {
                              if (value == true) {
                                //User exists
                                await sp.getUserDataFromFirestore(sp.uid).then((
                                    value) => sp.setSignIn().then((value) {nextScreenReplaced(context, const HomePage());}));
                              } else {
                                //User does not exist
                                sp.saveDataToFirestore().then((value) => sp.saveDataToSharedPreferences().then((value) => sp.setSignIn().then((value) {nextScreenReplaced(context, const HomePage());})));
                              }
                            });
                          },
                            child: const Text("Confirm")),
                    ],
                  ),
                );
                }
            );
            },
            codeAutoRetrievalTimeout: (String verification) {},
          );
      }
    }
  }
}
