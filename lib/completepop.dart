import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task1/profileimage.dart';

class Completepop extends StatefulWidget {
  const Completepop({super.key});

  @override
  State<Completepop> createState() => _CompletepopState();
}

class _CompletepopState extends State<Completepop> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.height * 0.7,
            maxHeight: MediaQuery.of(context).size.height * 0.75,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r)),
                  color: Colors.black,
                ),
                height: 50.h,
                child: Center(
                    child: Text(
                  'ORDER ID: #51654821512',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                )),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                padding: EdgeInsets.all(10.r),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCECECE)),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(children: [
                  Row(
                    children: [
                      Text(
                        'Truffle cake',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: Color(0xFF747474) // ✅ Hex color format
                            ),
                      ),
                      Spacer(),
                      Text(
                        'Rs. 500',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: Colors.black // ✅ Hex color format
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Choco cup cake',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: Color(0xFF747474) // ✅ Hex color format
                            ),
                      ),
                      Spacer(),
                      Text(
                        'Rs. 500',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: Colors.black // ✅ Hex color format
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'GST 12%',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: Color(0xFF747474) // ✅ Hex color format
                            ),
                      ),
                      Spacer(),
                      Text(
                        'Rs. 100',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: Colors.black // ✅ Hex color format
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Delivery charge',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: Color(0xFF747474) // ✅ Hex color format
                            ),
                      ),
                      Spacer(),
                      Text(
                        'Rs. 40',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: Colors.black // ✅ Hex color format
                            ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text(
                        'Grand total',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: Colors.black // ✅ Hex color format
                            ),
                      ),
                      Spacer(),
                      Text(
                        'Rs. 1140',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: Colors.black // ✅ Hex color format
                            ),
                      ),
                    ],
                  )
                ]),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                padding: EdgeInsets.all(10.r),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCECECE)),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Colors.black // ✅ Hex color format
                          ),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/location.png',
                          width: 13,
                          height: 13,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'From: 56, Hunters Road, Vepery',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: Color(0xFF747474) // ✅ Hex color format
                              ),
                        )
                      ],
                    ),
                    Image.asset(
                      'assets/line.png',
                      width: 12,
                      height: 12,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/location.png',
                          width: 13,
                          height: 13,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'From: 56, Hunters Road, Vepery',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: Color(0xFF747474) // ✅ Hex color format
                              ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                padding: EdgeInsets.all(10.r),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCECECE)),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Row(
                  children: [
                    Text(
                      'Payment method',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Colors.black // ✅ Hex color format
                          ),
                    ),
                    Spacer(),
                    Text(
                      'Cash on delivery',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: Color(0xFF747474) // ✅ Hex color format
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                padding: EdgeInsets.all(10.r),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCECECE)),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Row(
                  children: [
                    Text(
                      'Status',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Colors.black // ✅ Hex color format
                          ),
                    ),
                    Spacer(),
                    Text(
                      'Completed',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: Color(0xFF009062) // ✅ Hex color format
                          // ✅ Hex color format
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 45.h,
              ),
              Container(
                  //margin: EdgeInsets.only(left: 10, right: 16),
                  width: 214.w,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration:
                              Duration(milliseconds: 300), // Animation Speed
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Profileimage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0); // Start from Right
                            const end = Offset.zero; // End at Normal Position
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
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 17.sp),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Color(0xFFEB001D),
                    ),
                  )),
            ],
          ),
        ));
  }
}
