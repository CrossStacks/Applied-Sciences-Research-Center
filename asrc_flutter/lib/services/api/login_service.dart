import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:asrc_flutter/Utils/constants.dart';
import '../../models/login_models.dart';

Future<(LoginResponseModel?, String)> loginRequest(
    LoginRequestModel model) async {
  try {
    final url = Uri.parse(
        "${Constants.baseUrl}api/Auth/Login?email=${model.email}&password=${model.password}");

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      // body: jsonEncode({
      //   'email': model.email,
      //   'password': model.password,
      // }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      final loginResponse = LoginResponseModel.fromJson(responseBody);
      return (loginResponse, "Ok");
    } else {
      final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return (errorResponse['message'] ?? 'Unknown error');
    }
  } catch (e) {
    return (null, "Error: $e");
  }
}
