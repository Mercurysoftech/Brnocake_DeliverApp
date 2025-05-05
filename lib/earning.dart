import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/Services/Api_services.dart';
import 'package:task1/modelclass/EarningResponse.dart';
import 'package:task1/modelclass/earninghistory.dart';

class Earning extends StatefulWidget {
  const Earning({super.key});

  @override
  State<Earning> createState() => _EarningState();
}

class _EarningState extends State<Earning> {
  //String? todayBalance;

  EarningResponse? earningData;

  //List historyearning = [];
  // fetchBalance() async {
  //   String? balance = await Apiservices().wallet();
  //   setState(() {
  //     todayBalance = balance;
  //     print('today$todayBalance');
  //   });
  // }

  void fetchEarning() async {
    EarningResponse data = await Apiservices().todayearning();
    setState(() {
      earningData = data;
    });
  }

  // remove() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('token'); // 🔥 Token removed
  //   print('Token removed from storage');
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetchBalance();
    //Apiservices().todayearning();
    fetchEarning();
    //remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: Color(0xFFF1F1F1),
        title: Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Text(
            'Total Earning',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF101010)),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              //color: Color(0xFFFBFBFB),
              color: Color(0xFFFBFBFB),
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
                  fontSize: 15,
                  color: Color(0xFF9D9D9D)),
            ),
            subtitle: Text(
              '${earningData?.totalEarning ?? '0.00'}',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: Color(0xFFED2039)),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Daily earnings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 200,
              ),
              Image.asset(
                'assets/calender.png',
                width: 24,
                height: 24,
              )
            ],
          ),
        ),
        SizedBox(
          height: 13,
        ),
        earningData == null
            ? Center(child: CircularProgressIndicator())
            : (earningData!.status == true &&
                    earningData!.dailyEarnings.isEmpty)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 40),
                        Icon(Icons.info_outline, size: 50, color: Colors.grey),
                        SizedBox(height: 20),
                        Text(
                          "No data available",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: earningData?.dailyEarnings.length ?? 0,
                    itemBuilder: (context, index) {
                      var item = earningData!.dailyEarnings[index];
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xFFE0E0E0)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/note.png',
                                width: 42, height: 42),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.orderId,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Color(0xFF878787)),
                                  ),
                                  Text(
                                    "11561651654", // Optional: replace with item ID if needed
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  item.date,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 10,
                                      color: Color(0xFF878787)),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '₹${item.amount}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
      ])
          ////////////////////////////////////////////////////////////////////
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //     margin: EdgeInsets.only(left: 15, right: 15),
          //     decoration: BoxDecoration(
          //         color: Color(0xFFFFFFFF),
          //         border: Border.all(color: Color(0xFFE0E0E0)),
          //         borderRadius: BorderRadius.all(Radius.circular(10))),
          //     padding: EdgeInsets.all(10),
          //     child: Row(children: [
          //       Image.asset(
          //         'assets/note.png',
          //         width: 42,
          //         height: 42,
          //       ),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'order ID',
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w400,
          //                 fontSize: 14,
          //                 color: Color(0xFF878787)),
          //           ),
          //           Text(
          //             '11561651654',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w500,
          //               fontSize: 15,
          //             ),
          //           )
          //         ],
          //       ),
          //       SizedBox(
          //         width: 115,
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: [
          //           Text(
          //             '02/02/2025',
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w300,
          //                 fontSize: 10,
          //                 color: Color(0xFF878787)),
          //           ),
          //           SizedBox(
          //             height: 4,
          //           ),
          //           Text(
          //             '₹799',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w500,
          //               fontSize: 14,
          //             ),
          //           )
          //         ],
          //       )
          //     ])),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //     margin: EdgeInsets.only(left: 15, right: 15),
          //     decoration: BoxDecoration(
          //         color: Color(0xFFFFFFFF),
          //         border: Border.all(color: Color(0xFFE0E0E0)),
          //         borderRadius: BorderRadius.all(Radius.circular(10))),
          //     padding: EdgeInsets.all(10),
          //     child: Row(children: [
          //       Image.asset(
          //         'assets/note.png',
          //         width: 42,
          //         height: 42,
          //       ),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'order ID',
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w400,
          //                 fontSize: 14,
          //                 color: Color(0xFF878787)),
          //           ),
          //           Text(
          //             '11561651654',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w500,
          //               fontSize: 15,
          //             ),
          //           )
          //         ],
          //       ),
          //       SizedBox(
          //         width: 115,
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: [
          //           Text(
          //             '02/02/2025',
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w300,
          //                 fontSize: 10,
          //                 color: Color(0xFF878787)),
          //           ),
          //           SizedBox(
          //             height: 4,
          //           ),
          //           Text(
          //             '₹799',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w500,
          //               fontSize: 14,
          //             ),
          //           )
          //         ],
          //       )
          //     ])),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //     margin: EdgeInsets.only(left: 15, right: 15),
          //     decoration: BoxDecoration(
          //         color: Color(0xFFFFFFFF),
          //         border: Border.all(color: Color(0xFFE0E0E0)),
          //         borderRadius: BorderRadius.all(Radius.circular(10))),
          //     padding: EdgeInsets.all(10),
          //     child: Row(children: [
          //       Image.asset(
          //         'assets/note.png',
          //         width: 42,
          //         height: 42,
          //       ),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'order ID',
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w400,
          //                 fontSize: 14,
          //                 color: Color(0xFF878787)),
          //           ),
          //           Text(
          //             '11561651654',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w500,
          //               fontSize: 15,
          //             ),
          //           )
          //         ],
          //       ),
          //       SizedBox(
          //         width: 115,
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: [
          //           Text(
          //             '02/02/2025',
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w300,
          //                 fontSize: 10,
          //                 color: Color(0xFF878787)),
          //           ),
          //           SizedBox(
          //             height: 4,
          //           ),
          //           Text(
          //             '₹799',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w500,
          //               fontSize: 14,
          //             ),
          //           )
          //         ],
          //       )
          //     ])),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //     margin: EdgeInsets.only(left: 15, right: 15),
          //     decoration: BoxDecoration(
          //         color: Color(0xFFFFFFFF),
          //         border: Border.all(color: Color(0xFFE0E0E0)),
          //         borderRadius: BorderRadius.all(Radius.circular(10))),
          //     padding: EdgeInsets.all(10),
          //     child: Row(children: [
          //       Image.asset(
          //         'assets/note.png',
          //         width: 42,
          //         height: 42,
          //       ),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'order ID',
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w400,
          //                 fontSize: 14,
          //                 color: Color(0xFF878787)),
          //           ),
          //           Text(
          //             '11561651654',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w500,
          //               fontSize: 15,
          //             ),
          //           )
          //         ],
          //       ),
          //       SizedBox(
          //         width: 115,
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: [
          //           Text(
          //             '02/02/2025',
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w300,
          //                 fontSize: 10,
          //                 color: Color(0xFF878787)),
          //           ),
          //           SizedBox(
          //             height: 4,
          //           ),
          //           Text(
          //             '₹799',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w500,
          //               fontSize: 14,
          //             ),
          //           )
          //         ],
          //       )
          //     ])),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //     margin: EdgeInsets.only(left: 15, right: 15),
          //     decoration: BoxDecoration(
          //         color: Color(0xFFFFFFFF),
          //         border: Border.all(color: Color(0xFFE0E0E0)),
          //         borderRadius: BorderRadius.all(Radius.circular(10))),
          //     padding: EdgeInsets.all(10),
          //     child: Row(children: [
          //       Image.asset(
          //         'assets/note.png',
          //         width: 42,
          //         height: 42,
          //       ),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'order ID',
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w400,
          //                 fontSize: 14,
          //                 color: Color(0xFF878787)),
          //           ),
          //           Text(
          //             '11561651654',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w500,
          //               fontSize: 15,
          //             ),
          //           )
          //         ],
          //       ),
          //       SizedBox(
          //         width: 115,
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: [
          //           Text(
          //             '02/02/2025',
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w300,
          //                 fontSize: 10,
          //                 color: Color(0xFF878787)),
          //           ),
          //           SizedBox(
          //             height: 4,
          //           ),
          //           Text(
          //             '₹799',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w500,
          //               fontSize: 14,
          //             ),
          //           )
          //         ],
          //       )
          //     ])),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //     margin: EdgeInsets.only(left: 15, right: 15),
          //     decoration: BoxDecoration(
          //         color: Color(0xFFFFFFFF),
          //         border: Border.all(color: Color(0xFFE0E0E0)),
          //         borderRadius: BorderRadius.all(Radius.circular(10))),
          //     padding: EdgeInsets.all(10),
          //     child: Row(children: [
          //       Image.asset(
          //         'assets/note.png',
          //         width: 42,
          //         height: 42,
          //       ),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'order ID',
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w400,
          //                 fontSize: 14,
          //                 color: Color(0xFF878787)),
          //           ),
          //           Text(
          //             '11561651654',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w500,
          //               fontSize: 15,
          //             ),
          //           )
          //         ],
          //       ),
          //       SizedBox(
          //         width: 115,
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: [
          //           Text(
          //             '02/02/2025',
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w300,
          //                 fontSize: 10,
          //                 color: Color(0xFF878787)),
          //           ),
          //           SizedBox(
          //             height: 4,
          //           ),
          //           Text(
          //             '₹799',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w500,
          //               fontSize: 14,
          //             ),
          //           )
          //         ],
          //       )
          // ]))

          ),
    );
  }
}

class Orderitem extends StatelessWidget {
  const Orderitem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image.asset(
            'assets/note.png',
            width: 42,
            height: 42,
          )
        ],
      ),
    );
  }
}
