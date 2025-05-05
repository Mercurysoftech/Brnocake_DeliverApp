class Orederstatuscout {
  bool? status;
  String? message;
  OrderData data;

  Orederstatuscout({this.status, this.message, required this.data});

  factory Orederstatuscout.fromJson(Map<String, dynamic> json) {
    return Orederstatuscout(
        status: json['status'],
        message: json['message'],
        data: OrderData.fromJson(json['data']));
  }

  static List<Orederstatuscout> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => Orederstatuscout.fromJson(item)).toList();
  }
}

class OrderData {
  String? accepted;
  String? rejected;
  String? complete;

  OrderData({this.accepted, this.rejected, this.complete});

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
        accepted: json['accepted'],
        rejected: json['rejected'],
        complete: json['completed']);
  }
}
