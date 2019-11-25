import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:npa_user/model/models.dart';

class UserApiClient {
  static const baseUrl = "http://173.248.135.167/NpaTest";
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

  Future<void> register({
    @required String dateOfRegistration,
    @required String firstName,
    @required String lastName,
    @required int lpgmcId,
    @required int dealerId,
    @required String phoneNumber,
    @required String consumerId,
    @required String password,
    @required String houseNumber,
    @required String streetName,
    @required String residentialAddress,
    @required String ghanaPostGpsaddress,
    @required int districtId,
    @required int regionId,
    @required int depositeId,
    @required int cylinderSizeId,
    @required int statusId,
    @required double latitude,
    @required double longitude,
  }) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      // "dateOfRegistration": "$dateOfRegistration",
      "firstName": "$firstName",
      "lastName": "$lastName",
      "lpgmcId": lpgmcId,
      "dealerId": dealerId,
      "phoneNumber": "$phoneNumber",
      "consumerId": "$consumerId",
      "password": "$password",
      "houseNumber": "$houseNumber",
      "streetName": "$streetName",
      "residentialAddress": "$residentialAddress",
      "districtId": districtId,
      "regionId": regionId,
      "depositeId": depositeId,
      "cylinderSizeId": cylinderSizeId,
      "statusId": statusId,
      "ghanaPostGpsaddress": "$ghanaPostGpsaddress",
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
