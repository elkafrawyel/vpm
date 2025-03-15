class CarColorsResponse {
  CarColorsResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  CarColorsResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CarColorModel.fromJson(v));
      });
    }
  }

  num? statusCode;
  String? message;
  List<CarColorModel>? data;
}

class CarColorModel {
  CarColorModel({
    this.id,
    this.name,
    this.code,
    this.createdAt,
  });

  CarColorModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    createdAt = json['created_at'];
  }

  String? id;
  String? name;
  String? code;
  String? createdAt;

  @override
  String toString() {
    return name??'';
  }
}
