
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:proj27/main_module/HomePage.dart';


class OTPScreen extends StatefulWidget {

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  @override
  Widget build(BuildContext context) {

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffe91e63)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color(0xff3f51b5)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color(0xffffebee),
      ),
    );
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffffebee),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 70),
              child: SizedBox(
                width: size.width / 1.5,
                height: size.height / 1.8,
                child: Lottie.asset('assets/3.json'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70),
              child: Column(
                children: const <Widget> [
                  Padding(
                    padding: EdgeInsets.only(right: 70),
                    child: Text(
                        "Hold on! You will be logged in soon!",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 70, top: 15),
                    child: Text(
                      "Our lives at your service!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Pinput(
                length: 6,
                onSubmitted: (pin) async {
                },
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 36),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed:  () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffffffff),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 10,bottom: 10,left: 100,right: 100),
                      child: Text("Verify & Login",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff3f51b5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height/6,
              child: Padding(
                padding: const EdgeInsets.only(left: 125),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Text("Didn't recieve code?",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    InkWell(
                      onTap: (){},
                      child:
                      Text("Resend code",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
