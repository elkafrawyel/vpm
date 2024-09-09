import 'package:vpm/data/providers/storage/local_provider.dart';

class CountriesResponse {
  CountriesResponse({
    this.data,
  });

  CountriesResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CountryModel.fromJson(v));
      });
    }
  }

  List<CountryModel>? data;
}

class CountryModel {
  CountryModel({
    this.id,
    this.name,
    this.nameAr,
    this.phoneCode,
    this.flag,
    this.prefix,
  });

  CountryModel.fromJson(dynamic json) {
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return LocalProvider().isAr() ? nameAr! : name!;
  }
}
