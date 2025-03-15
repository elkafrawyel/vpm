class RegisterRequest {
  RegisterRequest({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.fileId,
    this.firebaseToken,
  });

  RegisterRequest.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    fileId = json['file_id'];
    firebaseToken = json['notification_token'];
  }

  String? name;
  String? email;
  String? phone;
  String? password;
  String? fileId;
  String? firebaseToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['password'] = password;
    map['file_id'] = fileId;
    map['notification_token'] = firebaseToken;
    return map;
  }
}
