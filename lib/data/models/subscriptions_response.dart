class SubscriptionsResponse {
  SubscriptionsResponse({
    this.data,
  });

  SubscriptionsResponse.fromJson(dynamic json) {
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
    this.userId,
    this.amount,
    this.startsAt,
    this.endsAt,
    this.createdAt,
    this.remainingDays,
    this.garage,
    this.autoRenew,
  });

  SubscriptionModel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    startsAt = json['starts_at'];
    endsAt = json['ends_at'];
    createdAt = json['created_at'];
    remainingDays = json['remaining_days'];
    autoRenew = json['auto_renew'];
    garage = json['garage'] != null ? Garage.fromJson(json['garage']) : null;
  }

  String? id;
  String? userId;
  num? amount;
  String? startsAt;
  String? endsAt;
  String? createdAt;
  String? remainingDays;
  Garage? garage;
  bool? autoRenew;

  SubscriptionModel copyWith({
    String? id,
    String? userId,
    num? amount,
    String? startsAt,
    String? endsAt,
    String? createdAt,
    String? remainingDays,
    Garage? garage,
    bool? autoRenew,
  }) =>
      SubscriptionModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        amount: amount ?? this.amount,
        startsAt: startsAt ?? this.startsAt,
        endsAt: endsAt ?? this.endsAt,
        createdAt: createdAt ?? this.createdAt,
        remainingDays: remainingDays ?? this.remainingDays,
        garage: garage ?? this.garage,
        autoRenew: autoRenew ?? this.autoRenew,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['amount'] = amount;
    map['starts_at'] = startsAt;
    map['ends_at'] = endsAt;
    map['created_at'] = createdAt;
    map['remaining_days'] = remainingDays;
    map['auto_renew'] = autoRenew;
    if (garage != null) {
      map['garage'] = garage?.toJson();
    }
    return map;
  }
}

class Garage {
  Garage({
    this.id,
    this.name,
    this.siteNumber,
    this.hourCost,
    this.maxCarCount,
    this.availableCarCount,
    this.reservedCarCount,
    this.longitude,
    this.latitude,
    this.openAt,
    this.closeAt,
    this.isAvailable,
    this.type,
    this.subscriptionPrice,
    this.country,
    this.governorate,
  });

  Garage.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    siteNumber = json['site_number'];
    hourCost = json['hour_cost'];
    maxCarCount = json['max_car_count'];
    availableCarCount = json['available_car_count'];
    reservedCarCount = json['reserved_car_count'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    openAt = json['open_at'];
    closeAt = json['close_at'];
    isAvailable = json['is_available'];
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
    subscriptionPrice = json['subscription_price'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    governorate = json['governorate'] != null
        ? Governorate.fromJson(json['governorate'])
        : null;
  }

  String? id;
  String? name;
  num? siteNumber;
  num? hourCost;
  num? maxCarCount;
  num? availableCarCount;
  num? reservedCarCount;
  String? longitude;
  String? latitude;
  String? openAt;
  String? closeAt;
  bool? isAvailable;
  Type? type;
  num? subscriptionPrice;
  Country? country;
  Governorate? governorate;

  Garage copyWith({
    String? id,
    String? name,
    num? siteNumber,
    num? hourCost,
    num? maxCarCount,
    num? availableCarCount,
    num? reservedCarCount,
    String? longitude,
    String? latitude,
    String? openAt,
    String? closeAt,
    bool? isAvailable,
    Type? type,
    num? subscriptionPrice,
    Country? country,
    Governorate? governorate,
  }) =>
      Garage(
        id: id ?? this.id,
        name: name ?? this.name,
        siteNumber: siteNumber ?? this.siteNumber,
        hourCost: hourCost ?? this.hourCost,
        maxCarCount: maxCarCount ?? this.maxCarCount,
        availableCarCount: availableCarCount ?? this.availableCarCount,
        reservedCarCount: reservedCarCount ?? this.reservedCarCount,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        openAt: openAt ?? this.openAt,
        closeAt: closeAt ?? this.closeAt,
        isAvailable: isAvailable ?? this.isAvailable,
        type: type ?? this.type,
        subscriptionPrice: subscriptionPrice ?? this.subscriptionPrice,
        country: country ?? this.country,
        governorate: governorate ?? this.governorate,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['site_number'] = siteNumber;
    map['hour_cost'] = hourCost;
    map['max_car_count'] = maxCarCount;
    map['available_car_count'] = availableCarCount;
    map['reserved_car_count'] = reservedCarCount;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['open_at'] = openAt;
    map['close_at'] = closeAt;
    map['is_available'] = isAvailable;
    if (type != null) {
      map['type'] = type?.toJson();
    }
    map['subscription_price'] = subscriptionPrice;
    if (country != null) {
      map['country'] = country?.toJson();
    }
    if (governorate != null) {
      map['governorate'] = governorate?.toJson();
    }
    return map;
  }
}

class Governorate {
  Governorate({
    this.id,
    this.countryId,
    this.name,
    this.nameAr,
    this.prefix,
  });

  Governorate.fromJson(dynamic json) {
    id = json['id'];
    countryId = json['country_id'];
    name = json['name'];
    nameAr = json['name_ar'];
    prefix = json['prefix'];
  }

  String? id;
  String? countryId;
  String? name;
  String? nameAr;
  String? prefix;

  Governorate copyWith({
    String? id,
    String? countryId,
    String? name,
    String? nameAr,
    String? prefix,
  }) =>
      Governorate(
        id: id ?? this.id,
        countryId: countryId ?? this.countryId,
        name: name ?? this.name,
        nameAr: nameAr ?? this.nameAr,
        prefix: prefix ?? this.prefix,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['country_id'] = countryId;
    map['name'] = name;
    map['name_ar'] = nameAr;
    map['prefix'] = prefix;
    return map;
  }
}

class Country {
  Country({
    this.id,
    this.name,
    this.nameAr,
    this.phoneCode,
    this.flag,
    this.prefix,
  });

  Country.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    phoneCode = json['phone_code'];
    flag = json['flag'];
    prefix = json['prefix'];
  }

  String? id;
  String? name;
  String? nameAr;
  String? phoneCode;
  dynamic flag;
  String? prefix;

  Country copyWith({
    String? id,
    String? name,
    String? nameAr,
    String? phoneCode,
    dynamic flag,
    String? prefix,
  }) =>
      Country(
        id: id ?? this.id,
        name: name ?? this.name,
        nameAr: nameAr ?? this.nameAr,
        phoneCode: phoneCode ?? this.phoneCode,
        flag: flag ?? this.flag,
        prefix: prefix ?? this.prefix,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['name_ar'] = nameAr;
    map['phone_code'] = phoneCode;
    map['flag'] = flag;
    map['prefix'] = prefix;
    return map;
  }
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
