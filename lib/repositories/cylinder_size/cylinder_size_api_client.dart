import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:npa_user/model/models.dart';

class CylinderSizeApiClient {
  static const baseUrl = "http://173.248.135.167/NpaTest";
  final http.Client httpClient;

  CylinderSizeApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<CylinderSize>> fetchCylinderSizes() async {
    final cylinderSizesUrl = "$baseUrl/api/CylinderSizeApi/CylinderSizes";
    final cylinderSizesResponse = await this.httpClient.get(cylinderSizesUrl);

    if (cylinderSizesResponse.statusCode != 200) {
      print(cylinderSizesResponse.statusCode);
      throw Exception('error getting cylinderSizes');
    }

    final reponse = jsonDecode(cylinderSizesResponse.body);
    var cylinderSizes = reponse["model"];
    List<CylinderSize> cylinderSizeList = [];
    for (var c in cylinderSizes) {
      cylinderSizeList.add(CylinderSize.fromJson(c));
    }

    return cylinderSizeList;
  }
}
