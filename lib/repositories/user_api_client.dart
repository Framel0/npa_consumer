import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:npa_user/model/models.dart';

class UserApiClient {
  static const baseUrl = "http://173.248.135.167/Npa";
  final http.Client httpClient;

  UserApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<User> login({
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
    var userJson = responseJson["model"];
    var user = User.fromJson(userJson);
    return user;
  }

  Future<User> getUserInfo({
    @required int userId,
  }) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final loginUrl = "$baseUrl/api/ConsumerApi/Consumer/$userId";

    final loginResponse = await this.httpClient.get(
          loginUrl,
        );

    if (loginResponse.statusCode != 200) {
      print(loginResponse.statusCode);
      throw Exception("Login failed, Please check Phone number or Password");
    }

    final responseJson = jsonDecode(loginResponse.body);
    var userJson = responseJson["model"];
    var user = User.fromJson(userJson);
    return user;
  }

  Future<void> register({
    @required String firstName,
    @required String lastName,
    @required int dealerId,
    @required String phoneNumber,
    @required String consumerId,
    @required String password,
    @required String houseNumber,
    @required String streetName,
    @required String residentialAddress,
    @required String ghanaPostGpsaddress,
    @required int districtId,
    @required int depositeId,
    @required int productId,
    @required double latitude,
    @required double longitude,
    @required String firebaseToken,
  }) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "firstName": "$firstName",
      "lastName": "$lastName",
      "dealerId": dealerId,
      "phoneNumber": "$phoneNumber",
      "consumerId": "$consumerId",
      "password": "$password",
      "houseNumber": "$houseNumber",
      "streetName": "$streetName",
      "residentialAddress": "$residentialAddress",
      "districtId": districtId,
      "depositeId": depositeId,
      "productId": productId,
      "ghanaPostGpsaddress": "$ghanaPostGpsaddress",
      "firebaseToken": "$firebaseToken",
      // "latitude": latitude,
      // "longitude": longitude,
    });
    final registernUrl = "$baseUrl/api/ConsumerApi/Register";
    final registerResponse =
        await this.httpClient.post(registernUrl, headers: headers, body: body);
    if (registerResponse.statusCode != 200) {
      throw Exception("Register Failed");
    }
    final responseJson = jsonDecode(registerResponse.body);
    var user = responseJson["model"];
  }
}
