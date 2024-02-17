import '../../domain/entities/models/image_model.dart';

class ContactsResponse {
  ContactsResponse({
    this.data,
  });

  ContactsResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ContactModel.fromJson(v));
      });
    }
  }

  List<ContactModel>? data;

  ContactsResponse copyWith({
    List<ContactModel>? data,
  }) =>
      ContactsResponse(
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ContactModel {
  ContactModel({
    this.id,
    this.client,
    this.clientId,
    this.customerId,
    this.name,
    this.email,
    this.phone,
    this.gender,
    this.birthday,
    this.createdAt,
    this.avatar,
  });

  ContactModel.fromJson(dynamic json) {
    id = json['id'];
    client = json['client'];
    clientId = json['client_id'];
    customerId = json['customer_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    birthday = json['birthday'];
    createdAt = json['created_at'];
    avatar = json['avatar'] != null ? ImageModel.fromJson(json['avatar']) : null;
  }

  String? id;
  dynamic client;
  dynamic clientId;
  dynamic customerId;
  String? name;
  dynamic email;
  String? phone;
  dynamic gender;
  dynamic birthday;
  String? createdAt;
  ImageModel? avatar;

  ContactModel copyWith({
    String? id,
    dynamic client,
    dynamic clientId,
    dynamic customerId,
    String? name,
    dynamic email,
    String? phone,
    dynamic gender,
    dynamic birthday,
    String? createdAt,
    ImageModel? avatar,
  }) =>
      ContactModel(
        id: id ?? this.id,
        client: client ?? this.client,
        clientId: clientId ?? this.clientId,
        customerId: customerId ?? this.customerId,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        createdAt: createdAt ?? this.createdAt,
        avatar: avatar ?? this.avatar,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['client'] = client;
    map['client_id'] = clientId;
    map['customer_id'] = customerId;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['gender'] = gender;
    map['birthday'] = birthday;
    map['created_at'] = createdAt;
    if (avatar != null) {
      map['avatar'] = avatar?.toJson();
    }
    return map;
  }
}
