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
    @required String firebaseToken,
  }) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final loginUrl = "$baseUrl/api/Consumer/Authenticate";
    final body = jsonEncode({
      "phoneNumber": "$phoneNumber",
      "password": "$password",
      "firebaseToken": "$firebaseToken",
    });

    final loginResponse =
        await this.httpClient.post(loginUrl, headers: headers, body: body);

    if (loginResponse.statusCode != 200) {
      print(loginResponse.statusCode);
      throw Exception("Login failed, Please check Phone number or Password");
    }

    final userJson = jsonDecode(loginResponse.body);
    var user = User.fromJson(userJson);
    return user;
  }

  Future<User> getUserInfo({
    @required int userId,
  }) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final loginUrl = "$baseUrl/api/Consumer/Consumer/$userId";

    final loginResponse = await this.httpClient.get(
          loginUrl,
        );

    if (loginResponse.statusCode != 200) {
      print(loginResponse.statusCode);
      throw Exception("Login failed, Please check Phone number or Password");
    }

    final userJson = jsonDecode(loginResponse.body);
    var user = User.fromJson(userJson);
    return user;
  }

  Future updateFirebaseToken({
    @required int userId,
    @required String firebaseToken,
  }) async {
    final url = "$baseUrl/api/Consumer/UpdateFirebaseToken/$userId";
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "firebaseToken": "$firebaseToken",
    });

    final response = await this.httpClient.put(
          url,
          headers: headers,
          body: body,
        );

    if (response.statusCode != 200) {
      print(response.statusCode);
      throw Exception("Login failed, Please check Phone number or Password");
    }
  }

  Future<void> register({
    @required String firstName,
    @required String lastName,
    @required int dealerId,
    @required String phoneNumber,
    @required String password,
    @required String houseNumber,
    @required String streetName,
    @required String residentialAddress,
    @required String ghanaPostGpsaddress,
    @required int districtId,
    @required int depositeId,
    @required int productId,
    @required int registrationType,
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
      "password": "$password",
      "houseNumber": "$houseNumber",
      "streetName": "$streetName",
      "residentialAddress": "$residentialAddress",
      "districtId": districtId,
      "depositeId": depositeId,
      "productId": productId,
      "ghanaPostGpsaddress": "$ghanaPostGpsaddress",
      "firebaseToken": "$firebaseToken",
      "registrationType": "$registrationType",
      // "latitude": latitude,
      // "longitude": longitude,
    });
    final registernUrl = "$baseUrl/api/Consumer/Register";
    final registerResponse =
        await this.httpClient.post(registernUrl, headers: headers, body: body);
    if (registerResponse.statusCode == 200) {
      print("debeg: user registration successful ");
    } else if (registerResponse.statusCode == 400) {
      var response = jsonDecode(registerResponse.body);
      var message = response["message"];
      print(
          "debeg: user registration error code:${registerResponse.statusCode}");
      throw Exception(message);
    } else if (registerResponse.statusCode == 500) {
      print(
          "debeg: user registration error code:${registerResponse.statusCode}");
      throw Exception("Services down, Please Try Agan Later");
    }
  }
}
