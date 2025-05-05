import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/Home.dart';
import 'package:task1/Locationgetpage.dart';
import 'package:task1/hometap.dart';
import 'package:task1/main.dart';
import 'package:task1/updatelocation.dart';

class MyWidget extends StatelessWidget {
  MyWidget({super.key});

  Future<bool> checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    String? registerToken = prefs.getString('registertoken');
    String? loginToken = prefs.getString('logintoken');

    print('Register token: $registerToken');
    print('Login token: $loginToken');

    // If either token exists and is not empty, go to Home
    if ((registerToken != null && registerToken.isNotEmpty) ||
        (loginToken != null && loginToken.isNotEmpty)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkAuthStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data == true) {
          return Updatelocation(); // or HomeTap() if that's your actual home screen
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
