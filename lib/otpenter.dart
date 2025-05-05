import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/Home.dart';
import 'package:task1/Services/Api_services.dart';
import 'package:task1/enterdtails.dart';
import 'package:task1/modelclass/basic_details.dart';

class Otpenter extends StatefulWidget {
  final sendOTP;
  final phoneNumber;
  Otpenter({super.key, required this.sendOTP, required this.phoneNumber});

  @override
  State<Otpenter> createState() => _OtpenterState();
}

class _OtpenterState extends State<Otpenter> {
  //var code = 1234;
  bool hasError = false;
  String enteredOTP = "";
  String? profilecompleted;
  String? status1;

  bool otpMatched = false;

  profilecompleed() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    profilecompleted = prefs.getString('auth_completed');
    return profilecompleted;
  }

  getstatus() async {
    String status = await Apiservices().login(widget.phoneNumber);
    setState(() {
      status1 = status;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profilecompleed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 17.w),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'OTP verification',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp),
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'We have sent a verification to',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: Color(0xFF6A6A6A)),
                  ),
                  Text(
                    '(+91) ${widget.phoneNumber}',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: Color(0xFF6A6A6A)),
                  ),
                  SizedBox(
                    height: 36.h,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Move to left
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OtpTextField(
                          fieldWidth: 50,
                          numberOfFields: 4,
                          borderColor: hasError
                              ? Colors.red
                              : (otpMatched ? Colors.green : Colors.grey),
                          focusedBorderColor: hasError
                              ? Colors.red
                              : (otpMatched ? Colors.green : Colors.blue),
                          showFieldAsBox: true,
                          margin: const EdgeInsets.only(left: 30),
                          onSubmit: (value) {
                            setState(() {
                              enteredOTP = value; // Save the entered OTP
                              if (enteredOTP == widget.sendOTP) {
                                hasError = false;
                                otpMatched = true;
                                print('$enteredOTP ✅ OTP matched!');
                              } else {
                                hasError = true;
                                otpMatched = false;
                                print('$enteredOTP ❌ OTP mismatch!');
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 38.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 16.w),
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (enteredOTP.isEmpty) {
                          setState(() {
                            hasError = true;
                          });
                          print('❗OTP field is empty');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter the OTP'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        if (enteredOTP == widget.sendOTP) {
                          print('✅ OTP matched! Navigating...');

                          var status = await Apiservices()
                              .login(widget.phoneNumber.toString().trim());
                          print('phonenumber: ${widget.phoneNumber}');
                          UserFormData().phone = widget.phoneNumber;
                          print('status: $status');

                          if (status.toString() == 'true') {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 300),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Home(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
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
                          } else {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 300),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        BasicDetailsScreen(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
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
                          }
                        } else {
                          setState(() {
                            hasError = true;
                          });
                          print('❌ OTP incorrect.');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Incorrect OTP. Try again.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Verify OTP',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 17.sp,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Color(0xFFEB001D),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
