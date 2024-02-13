class AddCarRequest {
  AddCarRequest({
    this.carColorId,
    this.carTypeId,
    this.name,
    this.number,
    this.fileId,
  });

  AddCarRequest.fromJson(dynamic json) {
    carColorId = json['car_color_id'];
    carTypeId = json['car_type_id'];
    name = json['name'];
    number = json['number'];
    fileId = json['file_id'];
  }

  String? carColorId;
  String? carTypeId;
  String? name;
  String? number;
  String? fileId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['car_color_id'] = carColorId;
    map['car_type_id'] = carTypeId;
    map['name'] = name;
    map['number'] = number;
    map['file_id'] = fileId;
    return map;
  }
}
