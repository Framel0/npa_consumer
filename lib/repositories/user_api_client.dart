import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:npa_user/model/models.dart';

class UserApiClient {
  static const baseUrl = "http://173.248.135.167/NpaTest";
  final http.Client httpClient;

  UserApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<String> login({
    @required String phoneNumber,
    @required String password,
  }) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final loginUrl = "$baseUrl/api/ConsumerApi/Authenticate";
    final body =
        jsonEncode({"phoneNumber": "$phoneNumber", "password": "$password"});

    final loginResponse =
        await this.httpClient.post(loginUrl, headers: headers, body: body);

    if (loginResponse.statusCode != 200) {
      print(loginResponse.statusCode);
      throw Exception("Login failed, Please check Phone number or Password");
    }

    final responseJson = jsonDecode(loginResponse.body);
    var user = responseJson["model"];
    return "token";
  }

  Future<void> register({
    @required String firstName,
    @required String lastName,
    @required String phoneNumber,
    @required String password,
    @required String consumerId,
    @required String residentialAddress,
    @required double latitude,
    @required double longitude,
    @required int dealerId,
  }) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "firstName": "$firstName",
      "lastName": "$lastName",
      "phoneNumber": "$phoneNumber",
      "consumerId": "$consumerId",
      "password": "$password",
      "residentialAddress": "$residentialAddress",
      "latitude": "$latitude",
      "longitude": "$longitude",
      "dealerId": "$dealerId",
    });
    final registernUrl = "$baseUrl/api/DealerApi/Register";
    final registerResponse =
        await this.httpClient.post(registernUrl, headers: headers, body: body);
    if (registerResponse.statusCode != 200) {
      throw Exception("Register Failed");
    }
    final responseJson = jsonDecode(registerResponse.body);
    var user = responseJson["model"];
  }
}
