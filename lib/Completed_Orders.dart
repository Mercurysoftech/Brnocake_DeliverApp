import 'package:flutter/material.dart';
import 'package:task1/Services/Api_services.dart';
import 'package:task1/modelclass/completeorder.dart';

class CompletedOrders extends StatefulWidget {
  const CompletedOrders({super.key});

  @override
  State<CompletedOrders> createState() => _CompletedOrdersState();
}

class _CompletedOrdersState extends State<CompletedOrders> {
  Completeorder? completeorder;

  void loadData() async {
    final data = await Apiservices().completeorderapi();
    setState(() {
      completeorder = data;
      print('dataaaaaaaa$completeorder');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Color(0xFFF1F1F1),
          leading: Transform.scale(
            scale: 0.4,
            child: IconButton(
              icon: Image.asset('assets/Arrow.png'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              'Completed Orders',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF101010),
              ),
            ),
          ),
        ),
        body: completeorder == null
            ? Column(
                children: [
                  SizedBox(height: 190),
                  Center(
                    child: Image.asset(
                      'assets/completeorder.png',
                      width: 205,
                      height: 210,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: completeorder!.orderid!.length,
                itemBuilder: (context, index) {
                  return buildOrderCard(completeorder!);
                },
              ));
  }
}

Widget buildOrderCard(Completeorder order) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Color(0xFFE0E0E0)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Image.asset('assets/note.png', width: 42, height: 42),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID',
                style: TextStyle(fontSize: 14, color: Color(0xFF878787))),
            Text(order.orderid ?? '',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          ],
        ),
        //   Spacer(),
        //   Column(
        //     crossAxisAlignment: CrossAxisAlignment.end,
        //     children: [
        //       Text(order.date ?? '',
        //           style: TextStyle(fontSize: 10, color: Color(0xFF878787))),
        //       SizedBox(height: 4),
        //       Text('₹${order.price ?? '0'}',
        //           style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        //     ],
        //   ),
      ],
    ),
  );
}
