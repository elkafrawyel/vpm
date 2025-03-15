import '../../domain/entities/models/booking_model.dart';
import '../../domain/entities/models/meta.dart';

class BookingResponse {
  BookingResponse({
    this.data,
    this.meta,
  });

  BookingResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BookingModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  List<BookingModel>? data;
  Meta? meta;
}
