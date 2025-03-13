// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../models/auth_models.dart';
// import '../../utils/constants.dart';

// Future<(AuthResponseModel?, String)> loginRequest(
//     LoginRequestModel model) async {
//   try {
//     final url = Uri.parse(
//         "${Constants.baseUrl}api/Auth/Login?email=${model.email}&password=${model.password}");

//     final response = await http.get(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       },
//       // body: jsonEncode({
//       //   'email': model.email,
//       //   'password': model.password,
//       // }),
//     );

//     if (response.statusCode == 200) {
//       final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
//       final loginResponse = AuthResponseModel.fromJson(responseBody);
//       return (loginResponse, "Ok");
//     } else {
//       final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
//       return (errorResponse['message'] ?? 'Unknown error');
//     }
//   } catch (e) {
//     return (null, "Error: $e");
//   }
// }

// Future<(AuthResponseModel?, String)> registerRequest(
//     SignupRequestModel model) async {
//   try {
//     final url = Uri.parse(
//         "${Constants.baseUrl}api/User/CreateUser?email=${model.email}&password=${model.password}&Name=${model.ame}&role=User");

//     final response = await http.post(url, headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     });

//     if (response.statusCode == 200) {
//       final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
//       final loginResponse = AuthResponseModel.fromJson(responseBody);
//       return (loginResponse, "Ok");
//     } else {
//       final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
//       return (errorResponse['message'] ?? 'Unknown error');
//     }
//   } catch (e) {
//     return (null, "Error: $e");
//   }
// }
