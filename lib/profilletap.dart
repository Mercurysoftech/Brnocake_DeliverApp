import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/Bank_Account_Details.dart';
import 'package:task1/Change_Address.dart';
import 'package:task1/aadherview.dart';
import 'package:task1/editprofile.dart';
import 'package:task1/main.dart';
import 'package:task1/modelclass/basic_details.dart';
import 'package:task1/notification.dart';
import 'package:task1/vechicle_details.dart';

class Profilletap extends StatefulWidget {
  const Profilletap({super.key});

  @override
  State<Profilletap> createState() => _ProfilletapState();
}

class _ProfilletapState extends State<Profilletap> {
  File? profileImage = UserFormData().profile;
  ImageProvider? profileImage1;
  String? profilename;
  String? phonenumber;

  final ImagePicker picker = ImagePicker();
  bool editpic = false;
  XFile? imageFile;
  Future pickImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = XFile(image.path);
        print('path${image.name}');
        editpic = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProfileImage();
    print('profilep$profileImage1');
  }

  void loadProfileImage() async {
    final pref = await SharedPreferences.getInstance();
    final path = pref.getString('profileimage');
    profilename = pref.getString('profilename');
    phonenumber = pref.getString('phonenumber');

    if (path != null && File(path).existsSync()) {
      setState(() {
        profileImage1 = FileImage(File(path));
        print('profile loaded: $profileImage1'); // ✅ Now it's not null
      });
    } else {
      print('No profile image found in SharedPreferences.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: () async {
      Navigator.pushReplacementNamed(context, '/Myhome'); // or your actual route name
      return false; // prevent the default back behavior
    },
      child: Scaffold(
          backgroundColor: Color(0xFFFFFFFF),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            backgroundColor: Color(0xFFF1F1F1),
            title: Padding(
              padding: const EdgeInsets.only(
                left: 22,
              ),
              child: Text(
                'Profile',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF101010)),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          CircleAvatar(
                            backgroundImage: editpic
                                ? FileImage(File(imageFile!.path))
                                : profileImage1, //!= null
                            // ? profileImage1
                            //: AssetImage('assets/human.png') as ImageProvider,
                            radius: 60,
                          ),
                          Positioned(
                              //bottom: -50,
                              left: 50,
                              top: 50,
                              child: GestureDetector(
                                onTap: () => pickImage(),
                                child: Image.asset(
                                  'assets/camera.png',
                                  width: 100,
                                  height: 100,
                                ),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${profilename}',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xFF757575)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${phonenumber}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                            color: Color(0xFF757575)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 30),
                          child: Text(
                            'Documents',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color
                          borderRadius:
                              BorderRadius.circular(14), // Border radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 2, // Spread shadow
                              blurRadius: 6, // Blur effect
                              offset: Offset(0, 0), // Shadow position (bottom)
                            ),
                            // BoxShadow(
                            //   color: Colors.grey
                            //       .withOpacity(0.3), // Extra shadow effect
                            //   spreadRadius: 2,
                            //   blurRadius: 4,
                            //   offset: Offset(-3, -3), // Shadow for left & top
                            // ),
                          ],
                        ),
                        child: SizedBox(
                          height: 52,
                          width: 331,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: Duration(
                                        milliseconds: 500), // Animation Speed
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        Aadherview(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin =
                                          Offset(1.0, 0.0); // Start from Right
                                      const end =
                                          Offset.zero; // End at Normal Position
                                      const curve = Curves.easeInOut;
      
                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);
      
                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 5, // Elevation (shadow effect)
                                  shadowColor: Colors.grey.withOpacity(0.6),
                                  backgroundColor: Color(0xFFFFFFFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)),
                                  )),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/aadhaaricon.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Aadhar',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  )
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color
                          borderRadius:
                              BorderRadius.circular(14), // Border radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 2, // Spread shadow
                              blurRadius: 6, // Blur effect
                              offset: Offset(0, 3), // Shadow position (bottom)
                            ),
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.3), // Extra shadow effect
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(-3, -3), // Shadow for left & top
                            ),
                          ],
                        ),
                        child: SizedBox(
                          height: 52,
                          width: 331,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: Duration(
                                        milliseconds: 500), // Animation Speed
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        VechicleDetails(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin =
                                          Offset(1.0, 0.0); // Start from Right
                                      const end =
                                          Offset.zero; // End at Normal Position
                                      const curve = Curves.easeInOut;
      
                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);
      
                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 5, // Elevation (shadow effect)
                                  shadowColor: Colors.grey.withOpacity(0.6),
                                  backgroundColor: Color(0xFFFFFFFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)),
                                  )),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/vehicle.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Vehicle Details',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  )
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color
                          borderRadius:
                              BorderRadius.circular(14), // Border radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 2, // Spread shadow
                              blurRadius: 6, // Blur effect
                              offset: Offset(0, 3), // Shadow position (bottom)
                            ),
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.3), // Extra shadow effect
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(-3, -3), // Shadow for left & top
                            ),
                          ],
                        ),
                        child: SizedBox(
                          height: 52,
                          width: 331,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: Duration(
                                        milliseconds: 500), // Animation Speed
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        BankAccountDetails(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin =
                                          Offset(1.0, 0.0); // Start from Right
                                      const end =
                                          Offset.zero; // End at Normal Position
                                      const curve = Curves.easeInOut;
      
                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);
      
                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 5, // Elevation (shadow effect)
                                  shadowColor: Colors.grey.withOpacity(0.6),
                                  backgroundColor: Color(0xFFFFFFFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)),
                                  )),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/bankicon.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Bank Account Details',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  )
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 30),
                          child: Text(
                            'Address',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color
                          borderRadius:
                              BorderRadius.circular(14), // Border radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 2, // Spread shadow
                              blurRadius: 6, // Blur effect
                              offset: Offset(0, 3), // Shadow position (bottom)
                            ),
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.3), // Extra shadow effect
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(-3, -3), // Shadow for left & top
                            ),
                          ],
                        ),
                        child: SizedBox(
                          height: 52,
                          width: 331,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: Duration(
                                        milliseconds: 500), // Animation Speed
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        ChangeAddress(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin =
                                          Offset(1.0, 0.0); // Start from Right
                                      const end =
                                          Offset.zero; // End at Normal Position
                                      const curve = Curves.easeInOut;
      
                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);
      
                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 5, // Elevation (shadow effect)
                                  shadowColor: Colors.grey.withOpacity(0.6),
                                  backgroundColor: Color(0xFFFFFFFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)),
                                  )),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/cl.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Change Address',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  )
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 30),
                          child: Text(
                            'Settings',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color
                          borderRadius:
                              BorderRadius.circular(14), // Border radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 2, // Spread shadow
                              blurRadius: 6, // Blur effect
                              offset: Offset(0, 3), // Shadow position (bottom)
                            ),
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.3), // Extra shadow effect
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(-3, -3), // Shadow for left & top
                            ),
                          ],
                        ),
                        child: SizedBox(
                          height: 52,
                          width: 331,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: Duration(
                                        milliseconds: 500), // Animation Speed
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        Notification1(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin =
                                          Offset(1.0, 0.0); // Start from Right
                                      const end =
                                          Offset.zero; // End at Normal Position
                                      const curve = Curves.easeInOut;
      
                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);
      
                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 5, // Elevation (shadow effect)
                                  shadowColor: Colors.grey.withOpacity(0.6),
                                  backgroundColor: Color(0xFFFFFFFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)),
                                  )),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/notification.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Notification Settings',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  )
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color
                          borderRadius:
                              BorderRadius.circular(14), // Border radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 2, // Spread shadow
                              blurRadius: 6, // Blur effect
                              offset: Offset(0, 3), // Shadow position (bottom)
                            ),
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.3), // Extra shadow effect
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(-3, -3), // Shadow for left & top
                            ),
                          ],
                        ),
                        child: SizedBox(
                          height: 52,
                          width: 331,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Logout"),
                                  content:
                                      Text("Are you sure you want to logout?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // close dialog
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        Navigator.of(context)
                                            .pop(); // close dialog
      
                                        final prefs =
                                            await SharedPreferences.getInstance();
      
                                        // String? registerToken =
                                        //     prefs.getString('registertoken');
                                        String? loginToken =
                                            prefs.getString('logintoken');
      
                                        // if (registerToken != null &&
                                        //     registerToken.isNotEmpty) {
                                        //   await prefs.remove('registertoken');
                                        // print('Register token removed');
                                        // }
      
                                        if (loginToken != null &&
                                            loginToken.isNotEmpty) {
                                          await prefs.remove('logintoken');
                                           await prefs.remove("isSwitched");
                                          print('Login token removed');
                                        }
      
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            transitionDuration:
                                                Duration(milliseconds: 500),
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                LoginScreen(),
                                            transitionsBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              const begin = Offset(1.0, 0.0);
                                              const end = Offset.zero;
                                              const curve = Curves.easeInOut;
      
                                              var tween = Tween(
                                                      begin: begin, end: end)
                                                  .chain(
                                                      CurveTween(curve: curve));
                                              var offsetAnimation =
                                                  animation.drive(tween);
      
                                              return SlideTransition(
                                                position: offsetAnimation,
                                                child: child,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Text("Logout",
                                          style: TextStyle(
                                            color: Colors.red,
                                          )),
                                    ),
                                  ],
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              shadowColor: Colors.grey.withOpacity(0.6),
                              backgroundColor: Color(0xFFFFFFFF),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14)),
                              ),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/logout.png',
                                  width: 24,
                                  height: 24,
                                ),
                                SizedBox(width: 20),
                                Text(
                                  'Log Out',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
