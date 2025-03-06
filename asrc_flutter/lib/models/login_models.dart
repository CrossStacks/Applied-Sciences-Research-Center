class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({required this.email, required this.password});
}

class LoginResponseModel {
  String email;
  String token;

  LoginResponseModel({required this.email, required this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      email: json['email'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
