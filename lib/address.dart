import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/modelclass/basic_details.dart';
import 'package:task1/upload.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  TextEditingController houseNo = TextEditingController();
  TextEditingController buildingNo = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();

  String? location;

  getaddress() async {
    final prefs = await SharedPreferences.getInstance();
    String? landmarkValue = await prefs.getString('area');
    String? cityValue = await prefs.getString('city');
    String? stateValue = await prefs.getString('state');
    location = await prefs.getString('location');

    landmark.text = landmarkValue ?? '';
    city.text = cityValue ?? '';
    state.text = stateValue ?? '';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getaddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {},
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                height: 7.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                  color: Color(0xFFEB001D), // Active step color
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              SizedBox(width: 10), // Gap between steps

                              Container(
                                height: 7.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                  color: Color(0xFFEB001D),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Container(
                                height: 7.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300], // Active step color
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Container(
                                height: 7.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300], // Active step color
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      'Enter your current address',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20.sp),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      'House Number',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: Color(0xFF3D3D3D)),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      controller: houseNo,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      'Building Name',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: Color(0xFF3D3D3D)),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      controller: buildingNo,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      'Landmark',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: Color(0xFF3D3D3D)),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      controller: landmark,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      'City',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: Color(0xFF3D3D3D)),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      controller: city,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      'State',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: Color(0xFF3D3D3D)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: state,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 20.h),
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            UserFormData().houuseNo = houseNo.text;
                            UserFormData().buildingNo = buildingNo.text;
                            UserFormData().landmark = landmark.text;
                            UserFormData().city = city.text;
                            UserFormData().state = state.text;
                            UserFormData().location = location!;
                            print('new page${UserFormData().data()}');
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(
                                    milliseconds: 300), // Animation Speed
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Upload(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin =
                                      Offset(1.0, 0.0); // Start from Right
                                  const end =
                                      Offset.zero; // End at Normal Position
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
                  ])),
        ));
  }
}
