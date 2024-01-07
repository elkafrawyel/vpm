class RegisterRequest {
  String? name, email, phone, password, countryCode, fcmToken, userType;

  RegisterRequest({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.countryCode,
    this.fcmToken,
    this.userType,
  });
}
