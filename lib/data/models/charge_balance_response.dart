class ChargeBalanceResponse {
  ChargeBalanceResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  ChargeBalanceResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  num? statusCode;
  String? message;
  Data? data;



}

class Data {
  Data({
    this.paymentLink,
  });

  Data.fromJson(dynamic json) {
    paymentLink = json['payment_link'];
  }

  String? paymentLink;
}
