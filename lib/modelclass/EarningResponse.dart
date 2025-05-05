class EarningResponse {
  final bool status;
  final String totalEarning;
  final List<EarningHistory> dailyEarnings;

  EarningResponse({
    required this.status,
    required this.totalEarning,
    required this.dailyEarnings,
  });

  factory EarningResponse.fromJson(Map<String, dynamic> json) {
    return EarningResponse(
      status: json['status'] ?? false,
      totalEarning: json['total_earning'] ?? "₹0.00",
      dailyEarnings: json['daily_earnings'] != null
          ? List<EarningHistory>.from(
              json['daily_earnings'].map((x) => EarningHistory.fromJson(x)))
          : [],
    );
  }
}

class EarningHistory {
  final String orderId;
  final String date;
  final String amount;

  EarningHistory({
    required this.orderId,
    required this.date,
    required this.amount,
  });

  factory EarningHistory.fromJson(Map<String, dynamic> json) {
    return EarningHistory(
      orderId: json['order_id'] ?? '',
      date: json['date'] ?? '',
      amount: json['amount'] ?? '0.00',
    );
  }
}
