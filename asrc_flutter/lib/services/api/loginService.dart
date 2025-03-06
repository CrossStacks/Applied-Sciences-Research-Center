import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:asrc_flutter/Utils/constants.dart';

Future<(http.Response?, String)> loginRequest(
    String email, String password) async {
  try {
    final url = Uri.parse(
        "${Constants.baseUrl}api/Auth/Login?email=$email&password=$password");

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      // body: body,
    );

    if (response.statusCode == 200) {
      return (response, "Ok");
    } else {
      final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return (errorResponse['message'] ?? 'Unknown error');
    }
  } catch (e) {
    print(e);
    return (null, "Error: $e");
  }
}
