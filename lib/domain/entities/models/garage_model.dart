class GarageModel {
  GarageModel({
    this.id,
    this.name,
    this.maxCarCount,
    this.availableCarCount,
    this.reservedCarCount,
    this.longitude,
    this.latitude,
    this.isAvailable = false,
  });

  GarageModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    maxCarCount = json['max_car_count'];
    availableCarCount = json['available_car_count'];
    reservedCarCount = json['reserved_car_count'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    isAvailable = json['is_available'] ?? false;
  }

  String? id;
  String? name;
  num? maxCarCount;
  num? availableCarCount;
  num? reservedCarCount;
  String? longitude;
  String? latitude;
  bool isAvailable = false;

  GarageModel copyWith({
    String? id,
    String? name,
    num? maxCarCount,
    num? availableCarCount,
    num? reservedCarCount,
    String? longitude,
    String? latitude,
    bool? isAvailable,
    num? distance,
  }) =>
      GarageModel(
        id: id ?? this.id,
        name: name ?? this.name,
        maxCarCount: maxCarCount ?? this.maxCarCount,
        availableCarCount: availableCarCount ?? this.availableCarCount,
        reservedCarCount: reservedCarCount ?? this.reservedCarCount,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        isAvailable: isAvailable ?? this.isAvailable,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['max_car_count'] = maxCarCount;
    map['available_car_count'] = availableCarCount;
    map['reserved_car_count'] = reservedCarCount;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['is_available'] = isAvailable;
    return map;
  }
}
