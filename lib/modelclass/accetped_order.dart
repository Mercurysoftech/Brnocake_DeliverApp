class OrderStatusResponse {
  bool? status;
  String? message;
  List<OrderItem>? data;

  OrderStatusResponse({this.status, this.message, this.data});

  factory OrderStatusResponse.fromJson(Map<String, dynamic> json) {
    return OrderStatusResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
    );
  }

  static List<OrderStatusResponse> orderStatusList(List<dynamic> jsonList) {
    return jsonList.map((item) => OrderStatusResponse.fromJson(item)).toList();
  }
}

class OrderItem {
  int? id;
  int? delUserid;
  String? orderid;
  String? paymentmethod;
  String? advancepaid;
  String? balanceamount;
  String? totalamount;
  String? currentat;
  String? orderStatus;

  OrderItem({
    this.id,
    this.delUserid,
    this.orderid,
    this.paymentmethod,
    this.advancepaid,
    this.balanceamount,
    this.totalamount,
    this.currentat,
    this.orderStatus,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      delUserid: json['del_userid'],
      orderid: json['orderid'],
      paymentmethod: json['paymentmethod'],
      advancepaid: json['advancepaid'],
      balanceamount: json['balanceamount'],
      totalamount: json['totalamount'],
      currentat: json['currentat'],
      orderStatus: json['order_status'],
    );
  }
}
