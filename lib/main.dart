import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/Home.dart';
import 'package:task1/Services/Api_services.dart';
import 'package:task1/Services/auth.dart';
import 'package:task1/Services/notifications.dart';
import 'package:task1/earning.dart';
import 'package:task1/history.dart';
import 'package:task1/hometap.dart';
import 'package:task1/otpenter.dart';
import 'package:task1/profilletap.dart';

void main() {
  //NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        initialRoute: '/Myhome',
        routes: {
          '/Myhome': (context) => Home(),
          '/Earning': (context) => Earning(),
          '/History': (context) => History(),
          '/profile': (context) => Profilletap(),
        },
        theme: ThemeData(fontFamily: GoogleFonts.ubuntu().fontFamily),
        home: MyWidget(),
      ),
      designSize: Size(360, 640),
      minTextAdapt: true, // Optional for text resizing
      splitScreenMode: true,
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _defulttext = TextEditingController(
    text: "+91",
  );
  final TextEditingController phoneNum = TextEditingController();
  int otp = 0000;

  //String cleanNumber = _phoneController.text.trim().replaceAll("+91", "").replaceAll(" ", "");
  getnumber() async {
    final pref = SharedPreferences.getInstance();

    await pref.then((value) => value.setString('phonenumber', phoneNum.text));
  }

  int generateOTP() {
    Random random = Random();
    return 1000 + random.nextInt(9000);
  }

  void onGainPressed() {
    setState(() {
      otp = generateOTP();
      print('OTP$otp');
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xFFF9B4BD),
              Color(0xFFFFFCFC),
              Color(0xFFF9B4BD),
              // Color(0xFFFFFCFC),

              // Color(0xFFFFFCFC),
              // Color(0xFFF9B4BD),
              // Color(0xFFFFFCFC),
              // Color(0xFFF9B4BD),
            ],
            //stops: [0.1, 0.6, 0.8],
            stops: [0.5, 0.7, .9],
            //stops: [0.6, 0.7, 0.6, 0.7],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          )),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.75, top: screenHeight * 0.07),
              child: Image.asset(
                'assets/Logo.png',
                width: 75,
                height: 18,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.012,
            ),
            Center(
              child: Image.asset(
                'assets/Character.png',
                width: 246,
                height: 216,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.09,
            ),
            Container(
              //constraints: BoxConstraints.expand(),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 0, right: 0),
              margin: EdgeInsets.only(left: 0, right: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              //width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30.h, left: 10.w),
                      child: Text(
                        'Enter your mobile number',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        'to get otp',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20.sp),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 52.h,
                            width: 59.w,
                            child: TextField(
                              readOnly: true,
                              controller: _defulttext,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFE5E5E5), width: 5.0)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: SizedBox(
                              height: 52.h,
                              width: 270.w,
                              child: TextField(
                                controller: phoneNum,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: '0000000000',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFE5E5E5),
                                          width: 5.0)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: SizedBox(
                        height: 50,
                        width: 420,
                        child: ElevatedButton(
                          onPressed: () async {
                            onGainPressed();
                            await Apiservices().sendSms(
                                phoneNumber: '+91' + phoneNum.text,
                                message: otp.toString());
                            print('okkkkkkkkkkk${phoneNum.text}');
                            await getnumber();
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(
                                    milliseconds: 200), // Animation Speed
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Otpenter(
                                            sendOTP: otp.toString(),
                                            phoneNumber: phoneNum.text),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin =
                                      Offset(1.0, 0.0); // Start from Right
                                  const end =
                                      Offset.zero; // End at Normal Position
                                  const curve = Curves.easeInOut;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);

                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEB001D),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          child: Text(
                            'Send OTP',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.09,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.013),
                      child: Text(
                        'By continuing, you agree to our Terms of Service & Privacy Policy',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: Color(0xFF8C8C8C)),
                      ),
                    ),
                    SizedBox(height: 100)
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
