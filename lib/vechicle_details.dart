import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VechicleDetails extends StatefulWidget {
  VechicleDetails({super.key});

  @override
  State<VechicleDetails> createState() => _VechicleDetailsState();
}

class _VechicleDetailsState extends State<VechicleDetails> {
  ImageProvider? drivingfront;

  ImageProvider? drivingback;

  void loadaadherImage() async {
    final pref = await SharedPreferences.getInstance();
    //final path = pref.getString('profileimage');
    final path = pref.getString('driving_F');
    //final pathback = pref.getString('aadherback');
    // phonenumber = pref.getString('phonenumber');

    if (path != null && File(path).existsSync()) {
      setState(() {
        drivingfront = FileImage(File(path));
        //aadherback = FileImage(File(pathback));
        print('profile loaded: $drivingfront'); // ✅ Now it's not null
      });
    } else {
      print('No profile image found in SharedPreferences.');
    }
  }

  void loaddrivingImage() async {
    final pref = await SharedPreferences.getInstance();
    //final path = pref.getString('profileimage');
    final path = pref.getString('driving_B');
    //final pathback = pref.getString('aadherback');
    // phonenumber = pref.getString('phonenumber');

    if (path != null && File(path).existsSync()) {
      setState(() {
        drivingback = FileImage(File(path));
        //aadherback = FileImage(File(pathback));
        print('profile loaded: $drivingback'); // ✅ Now it's not null
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
              'Vehicle Details',
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
                    if (drivingfront != null) {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image(
                              image: drivingfront!,
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
                    "License Image front view",
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
                    loaddrivingImage();
                    if (drivingback != null) {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image(
                              image: drivingback!,
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
                    "License Image back view",
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
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(right: 218),
                child: Text(
                  'Vehicles Type',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Color(0xFF3D3D3D)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(right: 190),
                child: Text(
                  'Vehicles Number',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Color(0xFF3D3D3D)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
