class SubscriptionResponse {
  SubscriptionResponse({
    this.data,
  });

  SubscriptionResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SubscriptionModel.fromJson(v));
      });
    }
  }

  List<SubscriptionModel>? data;
}

class SubscriptionModel {
  SubscriptionModel({
    this.id,
    this.name,
    this.type,
    this.subscriptionPrice,
  });

  SubscriptionModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
    subscriptionPrice = json['subscription_price'];
  }

  String? id;
  String? name;
  Type? type;
  num? subscriptionPrice;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscriptionModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class Type {
  Type({
    this.id,
    this.type,
    this.code,
    this.key,
    this.prefix,
    this.name,
    this.nameAr,
  });

  Type.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    code = json['code'];
    key = json['key'];
    prefix = json['prefix'];
    name = json['name'];
    nameAr = json['name_ar'];
  }

  String? id;
  String? type;
  num? code;
  String? key;
  String? prefix;
  String? name;
  String? nameAr;

  Type copyWith({
    String? id,
    String? type,
    num? code,
    String? key,
    String? prefix,
    String? name,
    String? nameAr,
  }) =>
      Type(
        id: id ?? this.id,
        type: type ?? this.type,
        code: code ?? this.code,
        key: key ?? this.key,
        prefix: prefix ?? this.prefix,
        name: name ?? this.name,
        nameAr: nameAr ?? this.nameAr,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['code'] = code;
    map['key'] = key;
    map['prefix'] = prefix;
    map['name'] = name;
    map['name_ar'] = nameAr;
    return map;
  }
}
