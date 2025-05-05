import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task1/aadheruupload.dart';
import 'package:task1/drivingpload.dart';

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _containerOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Listen to the tab changes to update the red container position
    _tabController.addListener(() {
      setState(() {
        _containerOffset = _tabController.index *
            80.0; // Adjust width of the container based on the tab
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
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
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          duration:
                              Duration(milliseconds: 300), // Animation duration
                          left:
                              _containerOffset, // Position of the red container
                          top: 0,
                          child: Container(
                            height: 7.h,
                            width: 70.w,
                            decoration: BoxDecoration(
                              color: Color(0xFFEB001D),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Gap between steps
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 300),
                          left: _containerOffset + 80.0, // Adjust the position
                          top: 0,
                          child: Container(
                            height: 7.h,
                            width: 70.w,
                            decoration: BoxDecoration(
                              color: Color(0xFFEB001D),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 300),
                          left: _containerOffset + 160.0, // Adjust the position
                          top: 0,
                          child: Container(
                            height: 7.h,
                            width: 70.w,
                            decoration: BoxDecoration(
                              color: Color(0xFFEB001D),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 300),
                          left: _containerOffset + 240.0, // Adjust the position
                          top: 0,
                          child: Container(
                            height: 7.h,
                            width: 70.w,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Text(
                'Upload your documents',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 15.h),
              // TAB BAR AND TAB VIEW
              Expanded(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Colors.red,
                        unselectedLabelColor: Colors.grey,
                        dividerColor: Colors.transparent, // Removes bottom line
                        indicatorSize: TabBarIndicatorSize
                            .label, // Moves underline to selected tab
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                              width: 3.0, color: Colors.red), // Red underline
                        ),
                        tabs: [
                          Tab(text: 'Aadhar'),
                          Tab(text: 'Driving License'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Aadheruupload(tabController: _tabController),
                          Drivingpload(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
