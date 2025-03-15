class VideoResponse {
  VideoResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  VideoResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? VideoModel.fromJson(json['data']) : null;
  }

  num? statusCode;
  String? message;
  VideoModel? data;
}

class VideoModel {
  VideoModel({
    this.id,
    this.vedio,
  });

  VideoModel.fromJson(dynamic json) {
    id = json['id'];
    vedio = json['vedio'] != null ? Vedio.fromJson(json['vedio']) : null;
  }

  String? id;
  Vedio? vedio;
}

class Vedio {
  Vedio({
    this.id,
    this.filePath,
    this.originalName,
  });

  Vedio.fromJson(dynamic json) {
    id = json['id'];
    filePath = json['file_path'];
    originalName = json['original_name'];
  }

  String? id;
  String? filePath;
  String? originalName;

  Vedio copyWith({
    String? id,
    String? filePath,
    String? originalName,
  }) =>
      Vedio(
        id: id ?? this.id,
        filePath: filePath ?? this.filePath,
        originalName: originalName ?? this.originalName,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['file_path'] = filePath;
    map['original_name'] = originalName;
    return map;
  }
}
