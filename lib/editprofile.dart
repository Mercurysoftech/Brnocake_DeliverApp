import 'package:flutter/material.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
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
          'Edit Profile',
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2F2F2F)),
        ),
      ),
      body: Column(children: [
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
                    backgroundImage: AssetImage('assets/human.png'),
                    radius: 80,
                  ),
                  Positioned(
                      bottom: -50,
                      left: 30,
                      child: Image.asset(
                        'assets/camera.png',
                        width: 100,
                        height: 100,
                      ))
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Name',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF727272)),
              ),
              SizedBox(
                height: 3,
              ),
              SizedBox(
                width: 331,
                height: 52,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Phone Number',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF727272)),
              ),
              SizedBox(
                height: 3,
              ),
              SizedBox(
                width: 331,
                height: 52,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Phone Number',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF727272)),
              ),
              SizedBox(
                height: 3,
              ),
              SizedBox(
                width: 331,
                height: 52,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
