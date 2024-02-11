class UpdateProfileRequest {
  UpdateProfileRequest({
    this.name,
    this.email,
    this.phone,
    this.gender,
    this.birthday,
    this.fileId,
  });

  UpdateProfileRequest.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    birthday = json['birthday'];
    fileId = json['file_id'];
  }

  String? name;
  String? email;
  String? phone;
  String? gender;
  String? birthday;
  String? fileId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['gender'] = gender;
    map['birthday'] = birthday;
    map['file_id'] = fileId;
    return map;
  }
}
