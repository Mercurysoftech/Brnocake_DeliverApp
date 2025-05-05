import 'package:flutter/material.dart';
import 'package:task1/profilletap.dart';

class ChangeAddress extends StatefulWidget {
  const ChangeAddress({super.key});

  @override
  State<ChangeAddress> createState() => _ChangeAddressState();
}

class _ChangeAddressState extends State<ChangeAddress> {
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
              'Change Address',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF101010)),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Enter your current address',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 23),
              ),
              SizedBox(
                height: 28,
              ),
              Text(
                'House Number',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFF3D3D3D)),
              ),
              SizedBox(
                height: 8,
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
                height: 18,
              ),
              Text(
                'Building Name',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFF3D3D3D)),
              ),
              SizedBox(
                height: 8,
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
                height: 18,
              ),
              Text(
                'Landmark',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFF3D3D3D)),
              ),
              SizedBox(
                height: 8,
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
                height: 18,
              ),
              Text(
                'City',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFF3D3D3D)),
              ),
              SizedBox(
                height: 8,
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
                height: 18,
              ),
              Text(
                'State',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFF3D3D3D)),
              ),
              SizedBox(
                height: 8,
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
                height: 60,
              ),
              Container(
                  //margin: EdgeInsets.only(left: 10, right: 16),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration:
                              Duration(milliseconds: 300), // Animation Speed
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Profilletap(),
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
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Color(0xFFEB001D),
                    ),
                  )),
            ]),
          ),
        ));
  }
}
