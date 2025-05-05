import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/drivingpload.dart';
import 'package:task1/modelclass/basic_details.dart';

class Aadheruupload extends StatefulWidget {
  final TabController tabController;
  const Aadheruupload({super.key, required this.tabController});

  @override
  State<Aadheruupload> createState() => _AadheruuploadState();
}

class _AadheruuploadState extends State<Aadheruupload> {
  final ImagePicker picker = ImagePicker();

  XFile? imageTemp;
  XFile? imageTempback;

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
        imageTemp = XFile(image.path);
        print('path${image.name}');
      });
      final pref = SharedPreferences.getInstance();

      await pref
          .then((value) => value.setString('aadherback', imageTemp!.path));
    }
  }

  Future pickImageback() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageTempback = XFile(image.path);
        print('path${image.name}');
      });
      final pref = SharedPreferences.getInstance();

      await pref
          .then((value) => value.setString('aadherfront', imageTemp!.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              fontSize: 15.sp,
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
              // Step 1: Check Permissions
              bool permissionGranted = await checkPermission(context);

              // Step 2: Pick Image only if permissions are granted
              if (permissionGranted) {
                await pickImage(); // Call image picker after permission check
                if (imageTemp != null) {
                  // Store the image in the singleton
                  UserFormData().aadhaarFront = File(imageTemp!.path);
                  print(
                      "Front image stored in UserFormData: ${UserFormData().data()}");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please upload the front image")),
                  );
                }
              } else {
                print("Permission denied, cannot pick image.");
              }
            },

            icon: Image.asset(
              'assets/upload.png',
              height: 28,
              width: 28,
            ), // Icon
            label: Text(
              imageTemp != null
                  ? imageTemp!.name
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
                    color: Color(0xFFC8C8C8), width: 2), // Border color & width
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
                await pickImageback();
                if (imageTempback != null) {
                  // Storing the image in the singleton
                  UserFormData().aadhaarBack = File(imageTempback!.path);
                  print(
                      "Front image stored in UserFormData${UserFormData().data()}");
                }
              }
            },

            icon: Image.asset(
              'assets/upload.png',
              height: 28,
              width: 28,
            ), // Icon
            label: Text(
              imageTempback != null
                  ? imageTempback!.name
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
                    color: Color(0xFFC8C8C8), width: 2), // Border color & width
              ),
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
                if (imageTemp != null && imageTempback != null)
                  widget.tabController.animateTo(1);
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please upload both images")),
                  );
                }
              },
              child: Text(
                'Next',
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
    );
  }
}
