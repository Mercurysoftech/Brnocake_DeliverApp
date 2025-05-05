class DeliverOrder {
  final bool status;
  final String message;
  final List<OrderData> data;

  DeliverOrder({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DeliverOrder.fromJson(Map<String, dynamic> json) {
    return DeliverOrder(
      status: json['status'],
      message: json['message'],
      data:
          List<OrderData>.from(json['data'].map((x) => OrderData.fromJson(x))),
    );
  }
}

class OrderData {
  final int id;
  final String orderid;
  final String paymentmethod;
  final String advancepaid;
  final String balanceamount;
  final String totalamount;
  final String currentat;
  final String orderStatus;

  OrderData({
    required this.id,
    required this.orderid,
    required this.paymentmethod,
    required this.advancepaid,
    required this.balanceamount,
    required this.totalamount,
    required this.currentat,
    required this.orderStatus,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'],
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
