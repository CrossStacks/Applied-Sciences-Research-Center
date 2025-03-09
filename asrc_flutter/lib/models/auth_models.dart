class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({required this.email, required this.password});
}

class AuthResponseModel {
  String email;
  String token;

  AuthResponseModel({required this.email, required this.token});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      email: json['email'] ?? '',
      token: json['token'] ?? '',
    );
  }
}

class SignupRequestModel {
  String email;
  String password;
  String name;

  SignupRequestModel(
      {required this.email, required this.password, required this.name});
}
