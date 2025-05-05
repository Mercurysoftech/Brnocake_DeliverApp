import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/Home.dart';
import 'package:task1/Services/Api_services.dart';
import 'package:task1/SubmissionSuccessScreen.dart';
import 'package:task1/modelclass/basic_details.dart';

class Profileimage extends StatefulWidget {
  const Profileimage({super.key});

  @override
  State<Profileimage> createState() => _ProfileimageState();
}

class _ProfileimageState extends State<Profileimage> {
  final ImagePicker picker = ImagePicker();
  XFile? imageFile;
  Future pickImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = XFile(image.path);
        print('path${image.name}');
      });
    }
  }

  storeprofic() async {
    final pref = SharedPreferences.getInstance();

    await pref
        .then((value) => value.setString('profileimage', imageFile!.path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {},
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              height: 7.h,
                              width: 70.w,
                              decoration: BoxDecoration(
                                color: Color(0xFFEB001D), // Active step color
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            SizedBox(width: 10), // Gap between steps

                            Container(
                              height: 7.h,
                              width: 70.w,
                              decoration: BoxDecoration(
                                color: Color(0xFFEB001D),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 7.h,
                              width: 70.w,
                              decoration: BoxDecoration(
                                color: Color(0xFFEB001D), // Active step color
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 7.h,
                              width: 70.w,
                              decoration: BoxDecoration(
                                color: Color(0xFFEB001D), // Active step color
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35.h,
                ),
                Text(
                  'Upload your profile photo',
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
                ),
                SizedBox(
                  height: 21.h,
                ),
                SizedBox(
                  height: 185,
                  width: 331,
                  child: TextButton.icon(
                    onPressed: () async {
                      await pickImage();
                      await storeprofic();

                      if (imageFile != null) {
                        // Storing the image in the singleton
                        UserFormData().profile = File(imageFile!.path);
                        print(
                            "Front image stored in UserFormData12${UserFormData().data()}");
                      }
                    },
                    icon: Image.asset(
                      'assets/upload.png',
                      height: 28,
                      width: 28,
                    ), // Icon
                    label: Text(
                      imageFile != null ? imageFile!.name : "Upload your photo",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: Color(0xFF747474)),
                    ), // Text
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFFFFF6F4),
                      foregroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10), // Button padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Rounded corners
                        side: BorderSide(
                            color: Color(0xFFC8C8C8),
                            width: 2), // Border color & width
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 250.h,
                ),
                Container(
                  width: 341,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Apiservices().enterDetails();
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration:
                              Duration(milliseconds: 300), // Animation Speed
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  SubmissionSuccessScreen(),
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
                  ),
                )
              ]),
        ));
  }
}
