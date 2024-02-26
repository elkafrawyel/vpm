import 'package:vpm/domain/entities/models/car_model.dart';
import 'package:vpm/domain/entities/models/garage_model.dart';

class BookingModel {
  BookingModel({
    this.id,
    this.startsAt,
    this.endsAt,
    this.totalCost,
    this.hourCost,
    this.freeHours,
    this.userId,
    this.garage,
    this.car,
  });

  BookingModel.fromJson(dynamic json) {
    id = json['id'];
    startsAt = json['starts_at'];
    endsAt = json['ends_at'];
    totalCost = json['total_cost'];
    hourCost = json['hour_cost'];
    freeHours = json['free_hours'];
    userId = json['user_id'];
    garage = json['garage'] != null ? GarageModel.fromJson(json['garage']) : null;
    car = json['car'] != null ? CarModel.fromJson(json['car']) : null;
  }

  String? id;
  String? startsAt;
  String? endsAt;
  num? totalCost;
  num? hourCost;
  num? freeHours;
  String? userId;
  GarageModel? garage;
  CarModel? car;
}
