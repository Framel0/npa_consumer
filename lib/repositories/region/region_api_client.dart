import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

class RegionApiClient {
  static const baseUrl = "http://173.248.135.167/Npa";
  final http.Client httpClient;

  RegionApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Region>> fetchRegions() async {
    final regionsUrl = "$baseUrl/api/RegionApi/Regions";
    final regionsResponse = await this.httpClient.get(regionsUrl);

    if (regionsResponse.statusCode != 200) {
      print(regionsResponse.statusCode);
      throw Exception('error getting regions');
    }

    final reponse = jsonDecode(regionsResponse.body);
    var regions = reponse["model"];
    List<Region> regionList = [];

    for (var r in regions) {
      regionList.add(Region.fromJson(r));
    }

    return regionList;
  }
}
