import 'package:flutter/material.dart';

class NotificationViewpage extends StatefulWidget {
  const NotificationViewpage({super.key});

  @override
  State<NotificationViewpage> createState() => _NotificationViewpageState();
}

class _NotificationViewpageState extends State<NotificationViewpage> {
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
            'Notification',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF101010)),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 190,
          ),
          Center(
              child: Image.asset(
            'assets/notifypageicon.png',
            width: 205,
            height: 210,
          )),
        ],
      ),
    );
  }
}
