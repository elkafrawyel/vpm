class CarTypesResponse {
  CarTypesResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  CarTypesResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CarTypeModel.fromJson(v));
      });
    }
  }

  num? statusCode;
  String? message;
  List<CarTypeModel>? data;
}

class CarTypeModel {
  CarTypeModel({
    this.id,
    this.name,
    this.createdAt,
  });

  CarTypeModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
  }

  String? id;
  String? name;
  String? createdAt;

  @override
  String toString() {
    return name??'';
  }
}
