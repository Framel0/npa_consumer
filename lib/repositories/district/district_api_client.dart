import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

class DistrictApiClient {
  static const baseUrl = "http://173.248.135.167/Npa";
  final http.Client httpClient;

  DistrictApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<District>> fetchDistricts() async {
    final districtsUrl = "$baseUrl/api/District/Districts";
    final districtsResponse = await this.httpClient.get(districtsUrl);

    if (districtsResponse.statusCode != 200) {
      print(districtsResponse.statusCode);
      throw Exception('error getting districts');
    }

    final districts = jsonDecode(districtsResponse.body);

    List<District> districtList = [];
    for (var d in districts) {
      districtList.add(District.fromJson(d));
    }

    return districtList;
  }
}
