import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notification1 extends StatefulWidget {
  const Notification1({super.key});

  @override
  State<Notification1> createState() => _Notification1State();
}

class _Notification1State extends State<Notification1> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/Arrow.png',
            height: 17, // Adjust as needed
            width: 10,
          ),
          onPressed: () {
            // Handle navigation
          },
        ),
        //automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: Color(0xFFF9F9F9),
        title: Text(
          'Notification Settings',
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2F2F2F)),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 2, // Spread shadow
                    blurRadius: 6, // Blur effect
                    offset: Offset(0, 3), // Shadow position (bottom)
                  ),
                ],
                //color: isSwitched ? Color(0xFFDBFFEE) : Color(0xFFFBC7CD),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(14))),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: ListTile(
              title: Text(
                'Notification Sound',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF3D3D3D),
                    fontSize: 18),
              ),
              trailing: SizedBox(
                width: 48,
                height: 26,
                child: CupertinoSwitch(
                    activeColor:
                        isSwitched ? Color(0xFF8BDAC2) : Color(0xFFDA8B8D),
                    thumbColor:
                        isSwitched ? Color(0xFF069A3A) : Color(0xFFB0B0B0),
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
