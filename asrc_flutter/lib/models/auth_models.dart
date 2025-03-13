// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  String firstName;
  String lastName;
  String qualification;
  String designation;
  String linkedinProfile;
  String profilePic;

  SignupRequestModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.qualification,
    required this.designation,
    required this.linkedinProfile,
    required this.profilePic,
  });
}
