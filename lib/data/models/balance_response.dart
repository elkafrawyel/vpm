class BalanceResponse {
  BalanceResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  BalanceResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? BalanceModel.fromJson(json['data']) : null;
  }

  num? statusCode;
  String? message;
  BalanceModel? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class BalanceModel {
  BalanceModel({
    this.userId,
    this.currentBalance,
    this.createdAt,
  });

  BalanceModel.fromJson(dynamic json) {
    userId = json['user_id'];
    currentBalance = json['current_balance'];
    createdAt = json['created_at'];
  }

  String? userId;
  num? currentBalance;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['current_balance'] = currentBalance;
    map['created_at'] = createdAt;
    return map;
  }
}
