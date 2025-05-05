import 'package:flutter/material.dart';
import 'package:task1/Services/Api_services.dart';
import 'package:task1/modelclass/rejectedorder.dart';

class RejectedOrders extends StatefulWidget {
  const RejectedOrders({super.key});

  @override
  State<RejectedOrders> createState() => _RejectedOrdersState();
}

class _RejectedOrdersState extends State<RejectedOrders> {
  Rejectedorder? rejectedorder;

  rejectedorderfun() async {
    var data = await Apiservices().rejectedorder();
    print('rejected1111111212$data');
    if (data == null) {
      print('data nllllllllllllllllllllllllllllllllllll');
    }
    setState(() {
      rejectedorder = data;

      print('tttttttttttttttttttttt]........$rejectedorder');
      print(' Current status: ${rejectedorder?.status}');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rejectedorderfun();
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
            'Rejected Orders',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF101010)),
          ),
        ),
      ),
      body: rejectedorder == null
          ? Center(child: CircularProgressIndicator()) // Loading
          : (rejectedorder!.status == true && rejectedorder!.data!.isNotEmpty)
              ? ListView.builder(
                  itemCount: rejectedorder!.data!.length,
                  itemBuilder: (context, index) {
                    final order = rejectedorder!.data![index];
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
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => Gmap(), // pass data
                              //   ),
                              // );
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
                          'assets/rejectorder.png',
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
