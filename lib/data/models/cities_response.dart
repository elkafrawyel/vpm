import 'package:vpm/data/providers/storage/local_provider.dart';

class CitiesResponse {
  CitiesResponse({
    this.data,
  });

  CitiesResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CityModel.fromJson(v));
      });
    }
  }

  List<CityModel>? data;
}

class CityModel {
  CityModel({
    this.id,
    this.countryId,
    this.name,
    this.nameAr,
    this.prefix,
  });

  CityModel.fromJson(dynamic json) {
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CityModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return LocalProvider().isAr() ? nameAr! : name!;
  }
}
