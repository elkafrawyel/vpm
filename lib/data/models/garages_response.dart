import 'package:vpm/domain/entities/models/garage_model.dart';

class GaragesResponse {
  GaragesResponse({
    this.garages,
  });

  GaragesResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      garages = [];
      json['data'].forEach((v) {
        garages?.add(GarageModel.fromJson(v));
      });
    }
  }

  List<GarageModel>? garages;
}

