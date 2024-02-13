class CarModel {
  CarModel({
    this.id,
    this.name,
    this.number,
    this.createdAt,
    this.color,
    this.type,
    this.image,
  });

  CarModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    createdAt = json['created_at'];
    color = json['color'] != null ? Color.fromJson(json['color']) : null;
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }

  String? id;
  String? name;
  String? number;
  String? createdAt;
  Color? color;
  Type? type;
  Image? image;

  CarModel copyWith({
    String? id,
    String? name,
    String? number,
    String? createdAt,
    Color? color,
    Type? type,
    Image? image,
  }) =>
      CarModel(
        id: id ?? this.id,
        name: name ?? this.name,
        number: number ?? this.number,
        createdAt: createdAt ?? this.createdAt,
        color: color ?? this.color,
        type: type ?? this.type,
        image: image ?? this.image,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['number'] = number;
    map['created_at'] = createdAt;
    if (color != null) {
      map['color'] = color?.toJson();
    }
    if (type != null) {
      map['type'] = type?.toJson();
    }
    if (image != null) {
      map['image'] = image?.toJson();
    }
    return map;
  }
}

class Image {
  Image({
    this.id,
    this.filePath,
    this.originalName,
  });

  Image.fromJson(dynamic json) {
    id = json['id'];
    filePath = json['file_path'];
    originalName = json['original_name'];
  }

  String? id;
  String? filePath;
  String? originalName;

  Image copyWith({
    String? id,
    String? filePath,
    String? originalName,
  }) =>
      Image(
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

class Type {
  Type({
    this.id,
    this.name,
    this.createdAt,
  });

  Type.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
  }

  String? id;
  String? name;
  String? createdAt;

  Type copyWith({
    String? id,
    String? name,
    String? createdAt,
  }) =>
      Type(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['created_at'] = createdAt;
    return map;
  }
}

class Color {
  Color({
    this.id,
    this.name,
    this.code,
    this.createdAt,
  });

  Color.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    createdAt = json['created_at'];
  }

  String? id;
  String? name;
  String? code;
  String? createdAt;

  Color copyWith({
    String? id,
    String? name,
    String? code,
    String? createdAt,
  }) =>
      Color(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    map['created_at'] = createdAt;
    return map;
  }
}
