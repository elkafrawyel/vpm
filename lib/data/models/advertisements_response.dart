import '../../domain/entities/models/advertisementModel.dart';

class AdvertisementsResponse {
  AdvertisementsResponse({
    this.data,
  });

  AdvertisementsResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AdvertisementModel.fromJson(v));
      });
    }
  }

  List<AdvertisementModel>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
