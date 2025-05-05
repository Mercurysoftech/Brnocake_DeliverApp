import 'package:flutter/material.dart';
import 'package:task1/Services/Api_services.dart';
import 'package:task1/Services/gmap.dart';
import 'package:task1/modelclass/accetped_order.dart';

class AcceptedOrders extends StatefulWidget {
  const AcceptedOrders({super.key});

  @override
  State<AcceptedOrders> createState() => _AcceptedOrdersState();
}

class _AcceptedOrdersState extends State<AcceptedOrders> {
  OrderStatusResponse? orderStatusResponse;

  accetedorder() async {
    var data = await Apiservices().accetptorder();
    print('accedorder$data');
    setState(() {
      orderStatusResponse = data;

      print('tttttttttttttttttttttt$orderStatusResponse');
      print(' Current status: ${orderStatusResponse?.status}');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accetedorder();
  }

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
            'Accepted Orders',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF101010)),
          ),
        ),
      ),
      body: orderStatusResponse == null
          ? Center(child: CircularProgressIndicator()) // Loading
          : (orderStatusResponse!.status == true)
              ? ListView.builder(
                  itemCount: orderStatusResponse!.data!.length,
                  itemBuilder: (context, index) {
                    final order = orderStatusResponse!.data![index];
                    return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            border: Border.all(color: Color(0xFFE0E0E0)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        // padding: EdgeInsets.all(10),
                        child: Row(children: [
                          Image.asset(
                            'assets/note.png',
                            width: 42,
                            height: 42,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'order ID',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color(0xFF878787)),
                              ),
                              Text(
                                '${order.orderid}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Gmap(), // pass data
                                ),
                              );
                            },
                            child: Image.asset(
                              'assets/forward.png',
                              width: 40,
                              height: 40,
                            ),
                          )
                        ]));
                  })
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Image.asset(
                          'assets/noaccept.png',
                          width: 205,
                          height: 210,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Text(
                      //   'No accepted orders yet.',
                      //   style: TextStyle(fontSize: 16, color: Colors.grey),
                      // ),
                    ],
                  ),
                ),
    );
  }
}
