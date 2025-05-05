import 'package:task1/Completed_Orders.dart';

class Completeorder {
  String? orderid;
  String? orderstatus;

  Completeorder({this.orderid, this.orderstatus});

  factory Completeorder.fromJson(Map<String, dynamic> json) {
    return Completeorder(
        orderid: json['order_id'].toString(),
        orderstatus: json['order_status'].toString());
  }

  static List<Completeorder> completedOrdersList(List<dynamic> jsonList) {
    return jsonList.map((item) => Completeorder.fromJson(item)).toList();
  }
}
