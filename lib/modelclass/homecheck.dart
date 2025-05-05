class HomeCheck {
  final bool status;
  final HomeCheckData data;

  HomeCheck({required this.status, required this.data});

  factory HomeCheck.fromJson(Map<String, dynamic> json) {
    return HomeCheck(
      status: json['status'],
      data: HomeCheckData.fromJson(json['data']),
    );
  }
}

class HomeCheckData {
  final int verifyStatus;
  final String? city;
  final String? location;
  final String? state;
  final String balance;
  final String createdAt;
  final String updatedAt;

  HomeCheckData({
    required this.verifyStatus,
    this.city,
    this.location,
    this.state,
    required this.balance,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HomeCheckData.fromJson(Map<String, dynamic> json) {
    return HomeCheckData(
      verifyStatus: json['verify_status'],
      city: json['city'],
      location: json['location'],
      state: json['state'],
      balance: json['balance'] ?? '0.00',
      createdAt: json['created_at'] ?? '0',
      updatedAt: json['updated_at'] ?? '0',
    );
  }
}
