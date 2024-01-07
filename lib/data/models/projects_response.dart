class ProjectsResponse {
  ProjectsResponse({
    this.currentPage,
    this.data,
    this.from,
    this.lastPage,
    this.nextPageUrl,
    this.perPage,
    this.total,
  });

  ProjectsResponse.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProjectModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  num? currentPage;
  List<ProjectModel>? data;
  String? firstPageUrl;
  num? from;
  num? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  num? perPage;
  dynamic prevPageUrl;
  num? to;
  num? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = firstPageUrl;
    map['from'] = from;
    map['last_page'] = lastPage;
    map['last_page_url'] = lastPageUrl;
    map['next_page_url'] = nextPageUrl;
    map['path'] = path;
    map['per_page'] = perPage;
    map['prev_page_url'] = prevPageUrl;
    map['to'] = to;
    map['total'] = total;
    return map;
  }
}

class ProjectModel {
  ProjectModel({
    this.id,
    this.type,
    this.imageId,
    this.cityId,
    this.districtId,
    this.name,
    this.commissionPerMillion,
    this.details,
    this.areaStart,
    this.priceStart,
    this.downPayment,
    this.garagePrice,
    this.serviceRoomPrice,
    this.serviceRoomWithBathroomPrice,
    this.installment,
    this.brochureUrl,
    this.lat,
    this.lng,
    this.createdAt,
    this.updatedAt,
    this.installmentLogoId,
    this.isHidden,
    this.developerId,
    this.sendReminder,
    this.unitTypes,
    this.masterplan,
    this.staticMasterPlan,
    this.developer,
    this.phases,
    this.image,
    this.district,
  });

  ProjectModel.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    imageId = json['image_id'];
    cityId = json['city_id'];
    districtId = json['district_id'];
    name = json['name'];
    commissionPerMillion = json['commission_per_million'];
    details = json['details'];
    areaStart = json['area_start'];
    priceStart = json['price_start'];
    downPayment = json['down_payment'];
    garagePrice = json['garage_price'];
    serviceRoomPrice = json['service_room_price'];
    serviceRoomWithBathroomPrice = json['service_room_with_bathroom_price'];
    installment = json['installment'];
    brochureUrl = json['brochure_url'];
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    installmentLogoId = json['installment_logo_id'];
    isHidden = json['is_hidden'];
    developerId = json['developer_id'];
    sendReminder = json['send_reminder'];
    if (json['unit_types'] != null) {
      unitTypes = [];
      json['unit_types'].forEach((v) {
        unitTypes?.add(UnitTypes.fromJson(v));
      });
    }
    masterplan = json['masterplan'];
    if (json['static_master_plan'] != null) {
      staticMasterPlan = [];
      json['static_master_plan'].forEach((v) {
        staticMasterPlan?.add(StaticMasterPlan.fromJson(v));
      });
    }
    developer = json['developer'] != null ? Developer.fromJson(json['developer']) : null;
    if (json['phases'] != null) {
      phases = [];
      json['phases'].forEach((v) {
        phases?.add(Phases.fromJson(v));
      });
    }
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    district = json['district'] != null ? District.fromJson(json['district']) : null;
  }

  int? id;
  String? type;
  num? imageId;
  dynamic cityId;
  num? districtId;
  String? name;
  num? commissionPerMillion;
  String? details;
  dynamic areaStart;
  dynamic priceStart;
  String? downPayment;
  String? garagePrice;
  dynamic serviceRoomPrice;
  dynamic serviceRoomWithBathroomPrice;
  dynamic installment;
  String? brochureUrl;
  dynamic lat;
  dynamic lng;
  String? createdAt;
  String? updatedAt;
  num? installmentLogoId;
  bool? isHidden;
  num? developerId;
  num? sendReminder;
  List<UnitTypes>? unitTypes;
  bool? masterplan;
  List<StaticMasterPlan>? staticMasterPlan;
  Developer? developer;
  List<Phases>? phases;
  Image? image;
  District? district;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['image_id'] = imageId;
    map['city_id'] = cityId;
    map['district_id'] = districtId;
    map['name'] = name;
    map['commission_per_million'] = commissionPerMillion;
    map['details'] = details;
    map['area_start'] = areaStart;
    map['price_start'] = priceStart;
    map['down_payment'] = downPayment;
    map['garage_price'] = garagePrice;
    map['service_room_price'] = serviceRoomPrice;
    map['service_room_with_bathroom_price'] = serviceRoomWithBathroomPrice;
    map['installment'] = installment;
    map['brochure_url'] = brochureUrl;
    map['lat'] = lat;
    map['lng'] = lng;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['installment_logo_id'] = installmentLogoId;
    map['is_hidden'] = isHidden;
    map['developer_id'] = developerId;
    map['send_reminder'] = sendReminder;
    if (unitTypes != null) {
      map['unit_types'] = unitTypes?.map((v) => v.toJson()).toList();
    }
    map['masterplan'] = masterplan;
    if (staticMasterPlan != null) {
      map['static_master_plan'] = staticMasterPlan?.map((v) => v.toJson()).toList();
    }
    if (developer != null) {
      map['developer'] = developer?.toJson();
    }
    if (phases != null) {
      map['phases'] = phases?.map((v) => v.toJson()).toList();
    }

    if (image != null) {
      map['image'] = image?.toJson();
    }
    if (district != null) {
      map['district'] = district?.toJson();
    }
    return map;
  }
}

class District {
  District({
    this.id,
    this.cityId,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  District.fromJson(dynamic json) {
    id = json['id'];
    cityId = json['city_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  num? cityId;
  String? name;
  dynamic createdAt;
  dynamic updatedAt;

  District copyWith({
    num? id,
    num? cityId,
    String? name,
    dynamic createdAt,
    dynamic updatedAt,
  }) =>
      District(
        id: id ?? this.id,
        cityId: cityId ?? this.cityId,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['city_id'] = cityId;
    map['name'] = name;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

class Image {
  Image({
    this.id,
    this.url,
    this.createdAt,
    this.updatedAt,
  });

  Image.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  String? url;
  String? createdAt;
  String? updatedAt;

  Image copyWith({
    num? id,
    String? url,
    String? createdAt,
    String? updatedAt,
  }) =>
      Image(
        id: id ?? this.id,
        url: url ?? this.url,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

class Phases {
  Phases({
    this.id,
    this.projectId,
    this.isFinished,
    this.serial,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
  });

  Phases.fromJson(dynamic json) {
    id = json['id'];
    projectId = json['project_id'];
    isFinished = json['is_finished'];
    serial = json['serial'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  num? projectId;
  num? isFinished;
  String? serial;
  dynamic startDate;
  dynamic endDate;
  String? createdAt;
  String? updatedAt;

  Phases copyWith({
    num? id,
    num? projectId,
    num? isFinished,
    String? serial,
    dynamic startDate,
    dynamic endDate,
    String? createdAt,
    String? updatedAt,
  }) =>
      Phases(
        id: id ?? this.id,
        projectId: projectId ?? this.projectId,
        isFinished: isFinished ?? this.isFinished,
        serial: serial ?? this.serial,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['project_id'] = projectId;
    map['is_finished'] = isFinished;
    map['serial'] = serial;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

class Developer {
  Developer({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  Developer.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  String? name;
  dynamic createdAt;
  String? updatedAt;

  Developer copyWith({
    num? id,
    String? name,
    dynamic createdAt,
    String? updatedAt,
  }) =>
      Developer(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

class StaticMasterPlan {
  StaticMasterPlan({
    this.id,
    this.projectId,
    this.imageId,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  StaticMasterPlan.fromJson(dynamic json) {
    id = json['id'];
    projectId = json['project_id'];
    imageId = json['image_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }

  num? id;
  num? projectId;
  num? imageId;
  String? createdAt;
  String? updatedAt;
  Image? image;

  StaticMasterPlan copyWith({
    num? id,
    num? projectId,
    num? imageId,
    String? createdAt,
    String? updatedAt,
    Image? image,
  }) =>
      StaticMasterPlan(
        id: id ?? this.id,
        projectId: projectId ?? this.projectId,
        imageId: imageId ?? this.imageId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        image: image ?? this.image,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['project_id'] = projectId;
    map['image_id'] = imageId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    return map;
  }
}

class UnitTypes {
  UnitTypes({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  UnitTypes.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  UnitTypes copyWith({
    num? id,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) =>
      UnitTypes(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
