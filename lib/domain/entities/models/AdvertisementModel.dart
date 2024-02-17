import 'package:vpm/domain/entities/models/image_model.dart';

class AdvertisementModel {
  AdvertisementModel({
    this.id,
    this.title,
    this.details,
    this.amount,
    this.link,
    this.createdAt,
    this.image,
  });

  AdvertisementModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    details = json['details'];
    amount = json['amount'].toString();
    link = json['link'];
    createdAt = json['created_at'];
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
  }

  String? id;
  String? title;
  String? details;
  String? amount;
  String? link;
  String? createdAt;
  ImageModel? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['details'] = details;
    map['amount'] = amount;
    map['link'] = link;
    map['created_at'] = createdAt;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    return map;
  }
}
