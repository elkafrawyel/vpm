class UploadFileResponse {
  UploadFileResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  UploadFileResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  num? statusCode;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.filePath,
    this.originalName,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    filePath = json['file_path'];
    originalName = json['original_name'];
  }

  String? id;
  String? filePath;
  String? originalName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['file_path'] = filePath;
    map['original_name'] = originalName;
    return map;
  }
}
