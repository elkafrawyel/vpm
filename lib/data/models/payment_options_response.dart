class PaymentOptionsResponse {
  PaymentOptionsResponse({
    this.data,
  });

  PaymentOptionsResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PaymentOptionModel.fromJson(v));
      });
    }
  }

  List<PaymentOptionModel>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class PaymentOptionModel {
  PaymentOptionModel({
    this.id,
    this.price,
  });

  PaymentOptionModel.fromJson(dynamic json) {
    id = json['id'];
    price = json['price'].toString();
  }

  String? id;
  String? price;
  bool selected = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['price'] = price;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is PaymentOptionModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
