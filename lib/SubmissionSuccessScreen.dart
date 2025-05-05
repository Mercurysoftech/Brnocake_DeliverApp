import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task1/Home.dart';

class SubmissionSuccessScreen extends StatefulWidget {
  @override
  _SubmissionSuccessScreenState createState() =>
      _SubmissionSuccessScreenState();
}

class _SubmissionSuccessScreenState extends State<SubmissionSuccessScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/animations/animation.json',
          width: 600,
          height: 600,
          repeat: false,
        ),
      ),
    );
  }
}
