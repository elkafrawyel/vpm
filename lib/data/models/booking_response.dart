
import '../../domain/entities/models/booking_model.dart';

class BookingResponse {
  BookingResponse({
    this.data,
  });

  BookingResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BookingModel.fromJson(v));
      });
    }
  }

  List<BookingModel>? data;
}

