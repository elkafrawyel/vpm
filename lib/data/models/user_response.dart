class UserResponse {
  UserResponse({
    this.token,
    this.user,
    this.userImage,
  });

  UserResponse.fromJson(dynamic json) {
    token = json['token'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    userImage = json['user_image'];
  }

  String? token;
  UserModel? user;
  dynamic userImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['user_image'] = userImage;
    return map;
  }
}

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.email,
    this.employeeCode,
    this.phone,
    this.otherPhone,
    this.role,
    this.isCLevel,
    this.fcmToken,
    this.teamId,
    this.jobTitle,
    this.imageId,
    this.brokerId,
    this.isActive,
    this.isTaken,
    this.about,
    this.facebookUrl,
    this.twitterUrl,
    this.instagramUrl,
    this.isSpecial,
    this.isArm,
    this.isAssistant,
    this.createdAt,
    this.updatedAt,
    this.canManagePaymentPlan,
    this.departmentId,
    this.isFullAccess,
    this.fcmMobileToken,
    this.roleDisplay,
    this.isSalesTeam,
    this.isSalesTopLevel,
    this.isDepartmentHead,
    this.department,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    employeeCode = json['employee_code'];
    phone = json['phone'];
    otherPhone = json['other_phone'];
    role = json['role'];
    isCLevel = json['is_c_level'];
    fcmToken = json['fcm_token'];
    teamId = json['team_id'];
    jobTitle = json['job_title'];
    imageId = json['image_id'];
    brokerId = json['broker_id'];
    isActive = json['is_active'];
    isTaken = json['is_taken'];
    about = json['about'];
    facebookUrl = json['facebook_url'];
    twitterUrl = json['twitter_url'];
    instagramUrl = json['instagram_url'];
    isSpecial = json['is_special'];
    isArm = json['is_arm'];
    isAssistant = json['is_assistant'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    canManagePaymentPlan = json['can_manage_payment_plan'];
    departmentId = json['department_id'];
    isFullAccess = json['is_full_access'];
    fcmMobileToken = json['fcm_mobile_token'];
    roleDisplay = json['role_display'];
    isSalesTeam = json['is_sales_team'];
    isSalesTopLevel = json['is_sales_top_level'];
    isDepartmentHead = json['is_department_head'];
    department = json['department'] != null ? Department.fromJson(json['department']) : null;
  }

  num? id;
  String? name;
  String? email;
  String? employeeCode;
  String? phone;
  dynamic otherPhone;
  String? role;
  num? isCLevel;
  String? fcmToken;
  dynamic teamId;
  String? jobTitle;
  dynamic imageId;
  dynamic brokerId;
  num? isActive;
  num? isTaken;
  dynamic about;
  dynamic facebookUrl;
  dynamic twitterUrl;
  dynamic instagramUrl;
  num? isSpecial;
  num? isArm;
  num? isAssistant;
  dynamic createdAt;
  String? updatedAt;
  bool? canManagePaymentPlan;
  num? departmentId;
  num? isFullAccess;
  String? fcmMobileToken;
  String? roleDisplay;
  bool? isSalesTeam;
  bool? isSalesTopLevel;
  bool? isDepartmentHead;
  Department? department;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['employee_code'] = employeeCode;
    map['phone'] = phone;
    map['other_phone'] = otherPhone;
    map['role'] = role;
    map['is_c_level'] = isCLevel;
    map['fcm_token'] = fcmToken;
    map['team_id'] = teamId;
    map['job_title'] = jobTitle;
    map['image_id'] = imageId;
    map['broker_id'] = brokerId;
    map['is_active'] = isActive;
    map['is_taken'] = isTaken;
    map['about'] = about;
    map['facebook_url'] = facebookUrl;
    map['twitter_url'] = twitterUrl;
    map['instagram_url'] = instagramUrl;
    map['is_special'] = isSpecial;
    map['is_arm'] = isArm;
    map['is_assistant'] = isAssistant;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['can_manage_payment_plan'] = canManagePaymentPlan;
    map['department_id'] = departmentId;
    map['is_full_access'] = isFullAccess;
    map['fcm_mobile_token'] = fcmMobileToken;
    map['role_display'] = roleDisplay;
    map['is_sales_team'] = isSalesTeam;
    map['is_sales_top_level'] = isSalesTopLevel;
    map['is_department_head'] = isDepartmentHead;
    if (department != null) {
      map['department'] = department?.toJson();
    }
    return map;
  }
}

class Department {
  Department({
    this.id,
    this.name,
    this.isCrmHeadDepartment,
    this.headUserId,
    this.createdAt,
    this.updatedAt,
  });

  Department.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    isCrmHeadDepartment = json['is_crm_head_department'];
    headUserId = json['head_user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  String? name;
  num? isCrmHeadDepartment;
  num? headUserId;
  String? createdAt;
  String? updatedAt;

  Department copyWith({
    num? id,
    String? name,
    num? isCrmHeadDepartment,
    num? headUserId,
    String? createdAt,
    String? updatedAt,
  }) =>
      Department(
        id: id ?? this.id,
        name: name ?? this.name,
        isCrmHeadDepartment: isCrmHeadDepartment ?? this.isCrmHeadDepartment,
        headUserId: headUserId ?? this.headUserId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['is_crm_head_department'] = isCrmHeadDepartment;
    map['head_user_id'] = headUserId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
