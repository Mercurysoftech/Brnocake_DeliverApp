import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/Home.dart';
import 'package:task1/modelclass/basic_details.dart';
import 'package:task1/profileimage.dart';

class Drivingpload extends StatefulWidget {
  const Drivingpload({super.key});

  @override
  State<Drivingpload> createState() => _DrivingploadState();
}

class _DrivingploadState extends State<Drivingpload> {
  TextEditingController vehicleNumberController = TextEditingController();
  String? selectedVehicle; // Selected item
  final ImagePicker picker = ImagePicker();

  XFile? imageTempD;
  XFile? imageTempDback;

  Future<bool> checkPermission(BuildContext context) async {
    bool permissionGranted = false;

    if (Platform.isAndroid) {
      var storagePermission = await Permission.storage.status;
      var photosPermission = await Permission.photos.status;

      if (storagePermission.isGranted || photosPermission.isGranted) {
        print('Permission already granted.');
        permissionGranted = true;
      } else {
        var requestStorage = await Permission.storage.request();
        var requestPhotos = await Permission.photos.request();

        if (requestStorage.isGranted || requestPhotos.isGranted) {
          print('Permission granted after request.');
          permissionGranted = true;
        } else {
          print('Permission permanently denied. Please enable in settings.');
          _showPermissionDialog(context); // Show dialog
        }
      }
    } else if (Platform.isIOS) {
      var photosPermission = await Permission.photos.status;

      if (photosPermission.isGranted) {
        print('Permission already granted.');
        permissionGranted = true;
      } else {
        var requestPhotos = await Permission.photos.request();

        if (requestPhotos.isGranted) {
          print('Permission granted after request.');
          permissionGranted = true;
        } else {
          print('Permission permanently denied. Please enable in settings.');
          _showPermissionDialog(context); // Show dialog
        }
      }
    }

    return permissionGranted;
  }

  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Permission Denied'),
        content: Text(
          'Storage permission is permanently denied. Please enable it in the settings to continue.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings(); // Open the app settings
            },
            child: Text('Go to Settings'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(
                  context); // Close the dialog if the user doesn't want to open settings
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future pickImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageTempD = XFile(image.path);
        print('path${image.name}');
      });
      final pref = SharedPreferences.getInstance();

      await pref
          .then((value) => value.setString('driving_F', imageTempD!.path));
    }
  }

  Future pickImageDback() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageTempDback = XFile(image.path);
        print('path${image.name}');
      });
      final pref = SharedPreferences.getInstance();

      await pref
          .then((value) => value.setString('driving_B', imageTempDback!.path));
    }
  }

  final List<String> vehicleTypes = [
    'None',
    'Scooty',
    'Bike',
    'Cab',
    'Refrigerated Van'
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
              text: 'Upload Front', // Main text
              style: TextStyle(
                color: Color(0xFF494949), // Gray color for main text
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: '*', // Asterisk
                  style: TextStyle(
                    color: Colors.red, // Red color for asterisk
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 80,
            width: 331,
            child: TextButton.icon(
              onPressed: () async {
                bool permissionGranted = await checkPermission(context);
                if (permissionGranted) {
                  pickImage();
                  if (imageTempD != null) {
                    // Storing the image in the singleton
                    UserFormData().dervingFront = File(imageTempD!.path);
                    print(
                        "Front image stored in UserFormData1${UserFormData().data()}");
                  }
                }
              },
              icon: Image.asset(
                'assets/upload.png',
                height: 28,
                width: 28,
              ), // Icon
              label: Text(
                imageTempD != null
                    ? imageTempD!.name
                    : "Upload Document (PNG/JPEG)",
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
                  borderRadius: BorderRadius.circular(12), // Rounded corners
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
          RichText(
            text: TextSpan(
              text: 'Upload Back', // Main text
              style: TextStyle(
                color: Color(0xFF494949), // Gray color for main text
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: '*', // Asterisk
                  style: TextStyle(
                    color: Colors.red, // Red color for asterisk
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 80,
            width: 331,
            child: TextButton.icon(
              onPressed: () async {
                bool permissionGranted = await checkPermission(context);
                if (permissionGranted) {
                  pickImageDback();
                  if (imageTempDback != null) {
                    // Storing the image in the singleton
                    UserFormData().dervingBack = File(imageTempDback!.path);
                    print(
                        "Front image stored in UserFormData2${UserFormData().data()}");
                  }
                }
              },
              icon: Image.asset(
                'assets/upload.png',
                height: 28,
                width: 28,
              ), // Icon
              label: Text(
                imageTempDback != null
                    ? imageTempDback!.name
                    : "Upload Document (PNG/JPEG)",
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
                  borderRadius: BorderRadius.circular(12), // Rounded corners
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
          RichText(
              text: TextSpan(
            text: 'Vehicles Type', // Main text
            style: TextStyle(
              color: Color(0xFF494949), // Gray color for main text
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            children: [
              TextSpan(
                text: '*', // Asterisk
                style: TextStyle(
                  color: Colors.red, // Red color for asterisk
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
          SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFF9F9F9), // Background color
              border: Border.all(
                  color: Colors.grey.shade300, width: 2), // Border color
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: InputBorder.none, // Remove default border
              ),
              value: selectedVehicle,
              hint: Text("None", style: TextStyle(color: Colors.black)),
              icon: Icon(Icons.keyboard_arrow_down), // Dropdown arrow
              isExpanded: true,

              items: vehicleTypes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedVehicle = newValue;
                  print('Selected Vehicle: $selectedVehicle');
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RichText(
              text: TextSpan(
            text: 'Vehicles Number', // Main text
            style: TextStyle(
              color: Color(0xFF494949), // Gray color for main text
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            children: [
              TextSpan(
                text: '*', // Asterisk
                style: TextStyle(
                  color: Colors.red, // Red color for asterisk
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: vehicleNumberController,
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
            height: 60,
          ),
          Container(
              //margin: EdgeInsets.only(left: 10, right: 16),
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Validation for image uploads
                  if (imageTempD == null || imageTempDback == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              "Please upload both front and back images.")),
                    );
                    return; // Stop further action if images are not selected
                  }

                  // Validation for vehicle type
                  if (selectedVehicle == null || selectedVehicle!.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please select a vehicle type.")),
                    );
                    return; // Stop further action if vehicle type is not selected
                  }

                  // Validation for vehicle number
                  String vehicleNumber = vehicleNumberController.text;
                  // Get the value from the vehicle number TextField (not shown here)
                  if (vehicleNumber.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter a vehicle number.")),
                    );
                    return; // Stop further action if vehicle number is not entered
                  }

                  // If all validations pass, navigate to the next page
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 300),
                        pageBuilder: (context, animation, secondaryAnimation) =>
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
                        }),
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
    );
  }
}
