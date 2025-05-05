import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/modelclass/basic_details.dart';

class Aadherview extends StatefulWidget {
  const Aadherview({super.key});

  @override
  State<Aadherview> createState() => _AadherviewState();
}

class _AadherviewState extends State<Aadherview> {
  ImageProvider? aadherfront;
  ImageProvider? aadherback;

  void loadaadherImage() async {
    final pref = await SharedPreferences.getInstance();
    //final path = pref.getString('profileimage');
    final path = pref.getString('aadherfront');
    //final pathback = pref.getString('aadherback');
    // phonenumber = pref.getString('phonenumber');

    if (path != null && File(path).existsSync()) {
      setState(() {
        aadherfront = FileImage(File(path));
        //aadherback = FileImage(File(pathback));
        print('profile loaded: $aadherfront'); // ✅ Now it's not null
      });
    } else {
      print('No profile image found in SharedPreferences.');
    }
  }

  void loadaadherbackImage() async {
    final pref = await SharedPreferences.getInstance();
    //final path = pref.getString('profileimage');
    // final path = pref.getString('aadherfront');
    final pathback = pref.getString('aadherback');
    // phonenumber = pref.getString('phonenumber');

    if (pathback != null && File(pathback).existsSync()) {
      setState(() {
        aadherback = FileImage(File(pathback));
        //aadherback = FileImage(File(pathback));
        print('profile loaded: $aadherback'); // ✅ Now it's not null
      });
    } else {
      print('No profile image found in SharedPreferences.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          toolbarHeight: 70,
          backgroundColor: Color(0xFFF1F1F1),
          leading: Transform.scale(
            scale:
                0.4, // Adjust scale (1.0 is default, decrease for smaller size)
            child: IconButton(
              icon: Image.asset(
                'assets/Arrow.png',
                fit: BoxFit.contain,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              'Aadhar ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF101010)),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Upload Front',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: Color(0xFF3D3D3D)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    'assets/greentick.png',
                    width: 18,
                    height: 18,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 80,
                width: 331,
                child: TextButton.icon(
                  onPressed: () {
                    loadaadherImage();
                    if (aadherfront != null) {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image(
                              image: aadherfront!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }

                    // Action
                  },
                  icon: Image.asset(
                    'assets/viewaadhericon.png',
                    height: 28,
                    width: 28,
                  ), // Icon
                  label: Text(
                    "Aadhar Image 1",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xFF747474)),
                  ), // Text
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFF9F9F9),
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
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    'Upload Back',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: Color(0xFF3D3D3D)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    'assets/greentick.png',
                    width: 18,
                    height: 18,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 80,
                width: 331,
                child: TextButton.icon(
                  onPressed: () {
                    loadaadherbackImage();
                    if (aadherback != null) {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image(
                              image: aadherback!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Text('Not verified'),
                          ),
                        ),
                      );
                    }

                    // Action
                  },
                  icon: Image.asset(
                    'assets/viewaadhericon.png',
                    height: 28,
                    width: 28,
                  ), // Icon
                  label: Text(
                    "Aadhar Image 2",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xFF747474)),
                  ), // Text
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFF9F9F9),
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
            ],
          ),
        ));
  }
}
