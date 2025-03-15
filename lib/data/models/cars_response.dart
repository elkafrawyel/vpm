import 'package:vpm/domain/entities/models/car_model.dart';

class CarsResponse {
  CarsResponse({
    this.data,
  });

  CarsResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CarModel.fromJson(v));
      });
    }
  }

  List<CarModel>? data;
}
