class OrderResponse {
  final String status;
  final String message;
  final List<Order> data;

  OrderResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      status: json['status'].toString(),
      message: json['message'].toString(),
      data: (json['data'] != null && json['data'] is List)
          ? List<Order>.from(
              json['data'].map((item) => Order.fromJson(item)),
            )
          : [], // Safe fallback to empty list
    );
  }
}

class Order {
  final String id;
  final String orderid;
  final String paymentmethod;
  final String advancepaid;
  final String balanceamount;
  final String totalamount;
  final String currentat;
  final String orderStatus;

  Order({
    required this.id,
    required this.orderid,
    required this.paymentmethod,
    required this.advancepaid,
    required this.balanceamount,
    required this.totalamount,
    required this.currentat,
    required this.orderStatus,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'].toString(),
      orderid: json['orderid'].toString(),
      paymentmethod: json['paymentmethod'].toString(),
      advancepaid: json['advancepaid'].toString(),
      balanceamount: json['balanceamount'].toString(),
      totalamount: json['totalamount'].toString(),
      currentat: json['currentat'].toString(),
      orderStatus: json['order_status'].toString(),
    );
  }
}
