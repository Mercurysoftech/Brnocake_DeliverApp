import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/Accepted_Orders.dart';
import 'package:task1/Completed_Orders.dart';
import 'package:task1/Locationgetpage.dart';
import 'package:task1/Notification_ViewPage.dart';
import 'package:task1/Rejected_Orders.dart';
import 'package:task1/Services/Api_services.dart';
import 'package:task1/Services/gmap.dart';
import 'package:task1/Services/notifications.dart';
import 'package:task1/completepop.dart';
import 'package:task1/modelclass/deliverorder.dart';
import 'package:task1/modelclass/homecheck.dart';
import 'package:task1/modelclass/orderlist.dart';
import 'package:task1/modelclass/orederstatuscout.dart';
import 'package:task1/profileimage.dart';
import 'package:task1/updatelocation.dart';
import 'package:url_launcher/url_launcher.dart';

class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  bool isSwitched = false;
  bool isLoading = true;
  String? token;

  Orederstatuscout? orderStatus;
  OrderResponse? orderlist;

  HomeCheck? homecheckdata;

  DeliverOrder? deliverOrder;

  void statucode() async {
    final status = await Apiservices().deliverstatus(isSwitched);
    print('status11: $status'); // ✅ Now this will print
  }

  void loadData() async {
    final data = await Apiservices().orderstatuscound();
    setState(() {
      orderStatus = data;
    });
  }

  //String? selectedOrderId;

  gettoken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('auth_token');
    print('token$token');
  }

  getorder() async {
    var orderdata = await Apiservices().orderlist();
    print('data: $orderdata');
    setState(() {
      orderlist = orderdata;
      print('orderlist: $orderlist');
      print("111111111112222${orderlist!.status}");
    });
  }

  homecheckfunction() async {
    var hdata = await Apiservices().homecheck();
    print('homing$hdata');
    setState(() {
      homecheckdata = hdata;
      print('setdata$homecheckdata');
      print('5555555555555${homecheckdata!.data.location}');
    });
  }

  deliveryorder() async {
    var deliverdata = await Apiservices().deliverorderlist();
    setState(() {
      deliverOrder = deliverdata;
      print('deliverdata$deliverdata');
    });
  }

  void loadSwitchState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedValue = prefs.getBool('isSwitched') ?? false;

    setState(() {
      isSwitched = savedValue;
      isLoading = false;
    });
  }

  void updateSwitchState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSwitched', value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettoken();
    loadData();
    getorder();
    NotificationService().initNotification();
    homecheckfunction();
    deliveryorder();
    loadSwitchState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   leading: Image.asset(
      //     'assets/location.png',
      //     width: 33,
      //     height: 33,
      //   ),
      //   title: Text('Your Location',
      //       style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           color: Color(0xFF666666),
      //           fontSize: 15.sp)),
      // ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Container(
                  color: Color(0xFFF9F9F9),
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Updatelocation()),
                        );
                      },
                      child: Image.asset(
                        'assets/location.png',
                        width: 33,
                        height: 33,
                      ),
                    ),
                    title: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Updatelocation()),
                        );
                      },
                      child: Text('Your Location',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF666666),
                              fontSize: 15.sp)),
                    ),
                    subtitle: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Updatelocation()),
                        );
                      },
                      child: Text(
                        '${homecheckdata?.data.location?.isNotEmpty ?? false ? homecheckdata!.data.location! : "not found"}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 19.sp),
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                Duration(milliseconds: 300), // Animation Speed
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    NotificationViewpage(),
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
                      },
                      child: Image.asset(
                        'assets/vector.png',
                        width: 18,
                        height: 22,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: isSwitched ? Color(0xFFDBFFEE) : Color(0xFFFBC7CD),
                      borderRadius: BorderRadius.all(Radius.circular(14))),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: ListTile(
                    title: Text(
                      'Available status',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF3E3E3E),
                          fontSize: 18),
                    ),
                    subtitle: Text(
                      '${isSwitched ? 'You are online' : 'You are offline'}',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: isSwitched ? Color(0xFF13A145) : Colors.red,
                          fontSize: 13),
                    ),
                    trailing: isLoading
                        ? CircularProgressIndicator()
                        : SizedBox(
                            width: 48,
                            height: 26,
                            child: CupertinoSwitch(
                                activeColor: isSwitched
                                    ? Color(0xFF8BDAC2)
                                    : Color(0xFFDA8B8D),
                                thumbColor: isSwitched
                                    ? Color.fromARGB(255, 8, 119, 15)
                                    : Colors.red,
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                    //isSwitched ? 1 : 0;
                                    print('isSwitched: $isSwitched');
                                  });
                                  updateSwitchState(value);

                                  print('working...........');
                                  gettoken();
                                  statucode();
                                  if (isSwitched == true) {
                                    NotificationService().showNotification(
                                        title:
                                            'Document Verification in Progress ',
                                        body:
                                            'Once completed, your verified orders will appear',
                                        payload: 'item x');
                                    print('fuction was working');
                                  }
                                }),
                          ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      color: Color(0xFFFFF1F3),
                      border: Border.all(color: Color(0xFFFFEDED)),
                      borderRadius: BorderRadius.all(Radius.circular(14))),
                  child: ListTile(
                    leading: Image.asset(
                      'assets/wallet.png',
                      width: 52,
                      height: 52,
                    ),
                    title: Text(
                      'Today earnings',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15.sp,
                          color: Color(0xFF9D9D9D)),
                    ),
                    subtitle: Text(
                      '${homecheckdata?.data?.balance ?? "0"}',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: Color(0xFFED2039)),
                    ),
                    trailing: Image.asset(
                      'assets/backarrow.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Total Orders',
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF3D3D3D)),
                  ),
                ),
                SizedBox(
                  height: 19,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                Duration(milliseconds: 300), // Animation Speed
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    AcceptedOrders(),
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
                        print('Yes Wroking');
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04),
                        height: 132,
                        width: 104,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                    0.2), // Shadow Color (20% opacity)
                                spreadRadius: 4, // Shadow Spread
                                blurRadius: 6, // Shadow Blur
                                offset: Offset(
                                  0,
                                  0,
                                ), // Shadow Position (X, Y)
                              ),
                            ],
                            color: Color(0xFFFFFFFF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Image.asset('assets/Frame.png',
                                  width: 50, height: 66),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Accepted',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color(0xFF555555)),
                              ),
                              Text(
                                orderStatus?.data.accepted ?? '0',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                Duration(milliseconds: 300), // Animation Speed
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    RejectedOrders(),
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
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.001),
                        //margin: EdgeInsets.symmetric(horizontal: 5),
                        //margin: EdgeInsets.symmetric(horizontal: 5),
                        height: 132,
                        width: 104,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                    0.2), // Shadow Color (20% opacity)
                                spreadRadius: 4, // Shadow Spread
                                blurRadius: 6, // Shadow Blur
                                offset: Offset(
                                  0,
                                  0,
                                ), // Shadow Position (X, Y)
                              ),
                            ],
                            color: Color(0xFFFFFFFF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Image.asset('assets/clockpack.png',
                                  width: 50, height: 66),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Rejected',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color(0xFF555555)),
                              ),
                              Text(
                                orderStatus?.data.rejected ?? '0',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                Duration(milliseconds: 300), // Animation Speed
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    CompletedOrders(),
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
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        height: 132,
                        width: 104,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                    0.2), // Shadow Color (20% opacity)
                                spreadRadius: 4, // Shadow Spread
                                blurRadius: 6, // Shadow Blur
                                offset: Offset(
                                  0,
                                  0,
                                ), // Shadow Position (X, Y)
                              ),
                            ],
                            color: Color(0xFFFFFFFF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Image.asset('assets/tickpack.png',
                                  width: 50, height: 66),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Completed',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color(0xFF555555)),
                              ),
                              Text(
                                orderStatus?.data.complete ?? '0',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Order list',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF3D3D3D)),
                  ),
                ),
                // SizedBox(
                //   height: 15,
                // ),
                orderlist == null
                    ? Center(child: CircularProgressIndicator())
                    : (orderlist!.status == 'true' &&
                            orderlist!.data.isNotEmpty)
                        ? ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: orderlist?.data.length ?? 0,
                            itemBuilder: (context, index) {
                              var order = orderlist!.data[index];
                              return Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    border:
                                        Border.all(color: Color(0xFFCECECE)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14))),
                                child: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: Image.asset(
                                        'assets/note.png',
                                        width: 34,
                                        height: 34,
                                      ),
                                      title: Text(
                                        'order ID',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: Color(0xFFA5A5A5),
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${order.orderid}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            color: Colors.black),
                                      ),
                                      trailing: Text(
                                        '${order.currentat}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: Color(0xFFA5A5A5)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Payment method',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Color(0xFF5F5F5F),
                                            ),
                                          ),
                                          Text(
                                            '${order.paymentmethod}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Color(0xFF5F5F5F),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Advanced paid',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Color(0xFF5F5F5F),
                                            ),
                                          ),
                                          Text(
                                            '${order.advancepaid}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Color(0xFF5F5F5F),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // SizedBox(height: 10),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Balance amount',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Color(0xFF5F5F5F),
                                            ),
                                          ),
                                          Text(
                                            '${order.balanceamount}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Color(0xFF5F5F5F),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total payment',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Color(0xFF5F5F5F),
                                            ),
                                          ),
                                          Text(
                                            '${order.totalamount}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Color(0xFF5F5F5F),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // SizedBox(height: 10),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    SizedBox(height: 10),
                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: 155,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      Completepop());
                                            },
                                            child: Text(
                                              'Reject',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.red),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              backgroundColor:
                                                  Color(0xFFFFF6F4),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 155,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      CustomDialog());
                                            },
                                            child: Text(
                                              'Accept',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 8, 119, 15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10),
                          )
                        : Center(
                            child: Image.asset(
                            'assets/orderlistimage.png',
                            width: 186,
                            height: 147,
                            fit: BoxFit.contain,
                          )),

                ////////////////////////////////////////////////////////
                // SizedBox(
                //   height: 20,
                // ),
                // Container(
                //   margin: EdgeInsets.only(left: 10, right: 10),
                //   padding: EdgeInsets.all(7),
                //   decoration: BoxDecoration(
                //       color: Color(0xFFFFFFFF),
                //       border: Border.all(color: Color(0xFFCECECE)),
                //       borderRadius: BorderRadius.all(Radius.circular(14))),
                //   child: Column(
                //     //crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       ListTile(
                //         leading: Image.asset(
                //           'assets/note.png',
                //           width: 34,
                //           height: 34,
                //         ),
                //         title: Text(
                //           'order ID',
                //           style: TextStyle(
                //             fontWeight: FontWeight.w600,
                //             fontSize: 13,
                //             color: Color(0xFFA5A5A5),
                //           ),
                //         ),
                //         subtitle: Text(
                //           '11561651654',
                //           style: TextStyle(
                //               fontWeight: FontWeight.w600,
                //               fontSize: 15,
                //               color: Colors.black),
                //         ),
                //         trailing: Text(
                //           '21 Min ago',
                //           style: TextStyle(
                //               fontWeight: FontWeight.w400,
                //               fontSize: 12,
                //               color: Color(0xFFA5A5A5)),
                //         ),
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Text(
                //         'Payment method----------------------------------Online',
                //         style: TextStyle(
                //             fontWeight: FontWeight.w400,
                //             fontSize: 15,
                //             color: Color(0xFF5F5F5F)),
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Text(
                //         'Advance paid--------------------------------------------799',
                //         style: TextStyle(
                //             fontWeight: FontWeight.w400,
                //             fontSize: 15,
                //             color: Color(0xFF5F5F5F)),
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Text(
                //         'Balance amount----------------------------------------300',
                //         style: TextStyle(
                //             fontWeight: FontWeight.w400,
                //             fontSize: 15,
                //             color: Color(0xFF5F5F5F)),
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Text(
                //         'total payment----------------------------------------1399',
                //         style: TextStyle(
                //             fontWeight: FontWeight.w400,
                //             fontSize: 15,
                //             color: Color(0xFF5F5F5F)),
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Text(
                //         'Duration--------------------------------------------25 Min',
                //         style: TextStyle(
                //             fontWeight: FontWeight.w400,
                //             fontSize: 15,
                //             color: Color(0xFF5F5F5F)),
                //       ),
                //       SizedBox(
                //         height: 30,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           Container(
                //             width: 155,
                //             height: 50,
                //             child: ElevatedButton(
                //               onPressed: () {},
                //               child: Text(
                //                 'Reject',
                //                 style: TextStyle(
                //                     fontWeight: FontWeight.w700,
                //                     color: Colors.red),
                //               ),
                //               style: ElevatedButton.styleFrom(
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(10),
                //                 ),
                //                 backgroundColor: Color(0xFFFFF6F4),
                //               ),
                //             ),
                //           ),
                //           Container(
                //             width: 155,
                //             height: 50,
                //             child: ElevatedButton(
                //               onPressed: () {},
                //               child: Text(
                //                 'Accept',
                //                 style: TextStyle(
                //                     fontWeight: FontWeight.w700,
                //                     color: Colors.white),
                //               ),
                //               style: ElevatedButton.styleFrom(
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(10),
                //                 ),
                //                 backgroundColor:
                //                     const Color.fromARGB(255, 8, 119, 15),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       SizedBox(
                //         height: 15,
                //       )
                //     ],
                //   ),
                // ),

                ///////////////////////////////////////////////////////////////////////////////////////////////
                SizedBox(
                  height: 20,
                ),
                // Container(
                //   margin: EdgeInsets.only(left: 10, right: 10),
                //   padding: EdgeInsets.all(7),
                //   decoration: BoxDecoration(
                //       color: Color(0xFFFFFFFF),
                //       border: Border.all(color: Color(0xFFCECECE)),
                //       borderRadius: BorderRadius.all(Radius.circular(14))),
                //   child: Column(
                //     //crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       ListTile(
                //         leading: Image.asset(
                //           'assets/note.png',
                //           width: 34,
                //           height: 34,
                //         ),
                //         title: Text(
                //           'order ID',
                //           style: TextStyle(
                //             fontWeight: FontWeight.w600,
                //             fontSize: 13,
                //             color: Color(0xFFA5A5A5),
                //           ),
                //         ),
                //         subtitle: Text(
                //           '11561651654',
                //           style: TextStyle(
                //               fontWeight: FontWeight.w600,
                //               fontSize: 15,
                //               color: Colors.black),
                //         ),
                //         trailing: Text(
                //           '21 Min ago',
                //           style: TextStyle(
                //               fontWeight: FontWeight.w400,
                //               fontSize: 12,
                //               color: Color(0xFFA5A5A5)),
                //         ),
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Text(
                //         'Payment method----------------------------------Online',
                //         style: TextStyle(
                //             fontWeight: FontWeight.w400,
                //             fontSize: 15,
                //             color: Color(0xFF5F5F5F)),
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Text(
                //         'Advance paid--------------------------------------------799',
                //         style: TextStyle(
                //             fontWeight: FontWeight.w400,
                //             fontSize: 15,
                //             color: Color(0xFF5F5F5F)),
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Text(
                //         'Balance amount----------------------------------------300',
                //         style: TextStyle(
                //             fontWeight: FontWeight.w400,
                //             fontSize: 15,
                //             color: Color(0xFF5F5F5F)),
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Text(
                //         'total payment----------------------------------------1399',
                //         style: TextStyle(
                //             fontWeight: FontWeight.w400,
                //             fontSize: 15,
                //             color: Color(0xFF5F5F5F)),
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Text(
                //         'Duration--------------------------------------------25 Min',
                //         style: TextStyle(
                //             fontWeight: FontWeight.w400,
                //             fontSize: 15,
                //             color: Color(0xFF5F5F5F)),
                //       ),
                //       SizedBox(
                //         height: 30,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           Container(
                //             width: 155,
                //             height: 50,
                //             child: ElevatedButton(
                //               onPressed: () {},
                //               child: Text(
                //                 'Reject',
                //                 style: TextStyle(
                //                     fontWeight: FontWeight.w700,
                //                     color: Colors.red),
                //               ),
                //               style: ElevatedButton.styleFrom(
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(10),
                //                 ),
                //                 backgroundColor: Color(0xFFFFF6F4),
                //               ),
                //             ),
                //           ),
                //           Container(
                //             width: 155,
                //             height: 50,
                //             child: ElevatedButton(
                //               onPressed: () {},
                //               child: Text(
                //                 'Accept',
                //                 style: TextStyle(
                //                     fontWeight: FontWeight.w700,
                //                     color: Colors.white),
                //               ),
                //               style: ElevatedButton.styleFrom(
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(10),
                //                 ),
                //                 backgroundColor:
                //                     const Color.fromARGB(255, 8, 119, 15),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       SizedBox(
                //         height: 15,
                //       )
                //     ],
                //   ),
                // )
                ///////////////////////////////////////////////////////////////////////////////
              ],
            ),
          ),
        ),
        Positioned(
          //right: 20,
          left: 10,
          top: 675,
          child: Container(
              padding: EdgeInsets.all(10),
              width: 355,
              height: 76,
              decoration: BoxDecoration(
                color: Color(0xFF56423E), // Background color (Optional)
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'order',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      Text(
                        '11561651654',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    width: 170,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Gmap()),
                        );
                      },
                      child: Text(
                        'Track location',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFEB001D),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  )
                ],
              )),
        ),
      ]),
    );
  }
}

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.height * 0.7,
            maxHeight: MediaQuery.of(context).size.height * 0.75,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r)),
                  color: Colors.black,
                ),
                height: 50.h,
                child: Center(
                    child: Text(
                  'ORDER ID: #51654821512',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                )),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                padding: EdgeInsets.all(10.r),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCECECE)),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(children: [
                  Row(
                    children: [
                      Text(
                        'Truffle cake',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: Color(0xFF747474) // ✅ Hex color format
                            ),
                      ),
                      Spacer(),
                      Text(
                        'Rs. 500',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: Colors.black // ✅ Hex color format
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Choco cup cake',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: Color(0xFF747474) // ✅ Hex color format
                            ),
                      ),
                      Spacer(),
                      Text(
                        'Rs. 500',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: Colors.black // ✅ Hex color format
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'GST 12%',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: Color(0xFF747474) // ✅ Hex color format
                            ),
                      ),
                      Spacer(),
                      Text(
                        'Rs. 100',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: Colors.black // ✅ Hex color format
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Delivery charge',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: Color(0xFF747474) // ✅ Hex color format
                            ),
                      ),
                      Spacer(),
                      Text(
                        'Rs. 40',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: Colors.black // ✅ Hex color format
                            ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text(
                        'Grand total',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: Colors.black // ✅ Hex color format
                            ),
                      ),
                      Spacer(),
                      Text(
                        'Rs. 1140',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: Colors.black // ✅ Hex color format
                            ),
                      ),
                    ],
                  )
                ]),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                padding: EdgeInsets.all(10.r),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCECECE)),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Colors.black // ✅ Hex color format
                          ),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/location.png',
                          width: 13,
                          height: 13,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'From: 56, Hunters Road, Vepery',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: Color(0xFF747474) // ✅ Hex color format
                              ),
                        )
                      ],
                    ),
                    Image.asset(
                      'assets/line.png',
                      width: 12,
                      height: 12,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/location.png',
                          width: 13,
                          height: 13,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'To: 56, Hunters Road, Vepery',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: Color(0xFF747474) // ✅ Hex color format
                              ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                padding: EdgeInsets.all(10.r),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCECECE)),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Row(
                  children: [
                    Text(
                      'Payment method',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Colors.black // ✅ Hex color format
                          ),
                    ),
                    Spacer(),
                    Text(
                      'Cash on delivery',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: Color(0xFF747474) // ✅ Hex color format
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                padding: EdgeInsets.all(10.r),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    //border: Border.all(color: const Color(0xFFCECECE)),
                    //borderRadius: BorderRadius.circular(15.r),
                    ),
                child: Row(
                  children: [
                    Text(
                      'Advance paid',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: Colors.black // ✅ Hex color format
                          ),
                    ),
                    Spacer(),
                    Text(
                      '500',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Color(0xFFA1A1A1) // ✅ Hex color format
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              Container(
                padding: EdgeInsets.all(10.r),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    //border: Border.all(color: const Color(0xFFCECECE)),
                    //borderRadius: BorderRadius.circular(15.r),
                    ),
                child: Row(
                  children: [
                    Text(
                      'Balance amount',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: Colors.black // ✅ Hex color format
                          ),
                    ),
                    Spacer(),
                    Text(
                      '640',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Color(0xFFA1A1A1) // ✅ Hex color format
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      //margin: EdgeInsets.only(left: 10, right: 16),
                      width: 145.w,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(
                                  milliseconds: 300), // Animation Speed
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      Profileimage(),
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
                          'Not Now',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFA1A1A1),
                              fontSize: 17.sp),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color:
                                  Color(0xFFD4D4D4), // ✅ Hex color for border
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.white,
                        ),
                      )),
                  Spacer(),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      //margin: EdgeInsets.only(left: 10, right: 16),
                      width: 145.w,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(
                                  milliseconds: 300), // Animation Speed
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      Gmap(),
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
                          'Start Order',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white // ✅ Hex color format
                              ,
                              fontSize: 17.sp),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      )),
                ],
              )
            ],
          ),
        ));
  }
}
