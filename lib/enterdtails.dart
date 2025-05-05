import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/Locationgetpage.dart';
import 'package:task1/address.dart';
import 'package:task1/modelclass/basic_details.dart';
import 'package:task1/otpenter.dart';

class BasicDetailsScreen extends StatefulWidget {
  @override
  _BasicDetailsScreenState createState() => _BasicDetailsScreenState();
}

class _BasicDetailsScreenState extends State<BasicDetailsScreen> {
  bool isMaleSelected = true;
  int selectedIndex = 0;
  final _formKey = GlobalKey<FormState>();

  List<String> genderOptions = ['Male', 'Female'];

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController mnameController = TextEditingController();

  getname() async {
    final pref = SharedPreferences.getInstance();

    await pref
        .then((value) => value.setString('profilename', fnameController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        SizedBox(width: 10.w), // Gap between steps
                        for (int i = 0; i < 3; i++) ...[
                          Container(
                            height: 7.h,
                            width: 72.w,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          if (i < 2) SizedBox(width: 10.w),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Text(
                "Enter details",
                style: GoogleFonts.ubuntu(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'First Name',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: Color(0xFF5E5E5E)),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'First Name is required';
                          }
                          return null;
                        },
                        controller: fnameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFD6D6D6)),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'Middle Name',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: Color(0xFF5E5E5E)),
                          ),
                          Text(
                            '(optional)',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xFF939393)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      TextFormField(
                        controller: mnameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFD6D6D6)),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      Text(
                        'Last Name',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: Color(0xFF5E5E5E)),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'last Name is required';
                          }
                          return null;
                        },
                        controller: lnameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFD6D6D6)),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      Text(
                        'Gender',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: Color(0xFF5E5E5E)),
                      ),
                      SizedBox(
                        height: 6.sp,
                      ),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          //border: BorderRadius.only(bottomRight: Radius.circular(10))
                          border: Border.all(
                              color: Color(0xFFD6D6D6)), // Border color
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 0;
                                    String selectedGender =
                                        genderOptions[selectedIndex];
                                    print(selectedGender);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selectedIndex == 0
                                        ? Color(0xFFFF3C54)
                                        : Colors.white,
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(10),
                                        right: Radius.circular(10)),
                                    //borderRadius: BorderRadius.all(10)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Male",
                                      style: TextStyle(
                                          color: selectedIndex == 0
                                              ? Colors.white
                                              : Color(0xFF5E5E5E),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.sp),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 1;
                                    String selectedGender =
                                        genderOptions[selectedIndex];
                                    print(selectedGender);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selectedIndex == 1
                                        ? Color(0xFFFF3C54)
                                        : Colors.white,
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(10),
                                        left: Radius.circular(10)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Female",
                                      style: TextStyle(
                                          color: selectedIndex == 1
                                              ? Colors.white
                                              : Color(0xFF5E5E5E),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.sp),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: 85.h,
              ),
              Container(
                  //margin: EdgeInsets.only(left: 10, right: 16),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        UserFormData().name = fnameController.text;
                        UserFormData().middlename = mnameController.text;
                        UserFormData().lastname = lnameController.text;
                        UserFormData().gender = genderOptions[selectedIndex];
                        await getname();
                        print('Details${UserFormData().data()}');
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                Duration(milliseconds: 300), // Animation Speed
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Locationgetpage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin =
                                  Offset(1.0, 0.0); // Start from Right
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
                      }
                      ;
                    },
                    ////////////////////////////////////////
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
        ),
      ),
    );
  }
}
