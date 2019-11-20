import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:npa_user/model/models.dart';

class CylinderApiClient {
  static const baseUrl = "http://173.248.135.167/NpaTest";
  final http.Client httpClient;

  CylinderApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Cylinder>> fetchCylinders() async {
    final cylindersUrl = "$baseUrl/api/CylinderApi/Cylinders";
    final cylindersResponse = await this.httpClient.get(cylindersUrl);

    if (cylindersResponse.statusCode != 200) {
      print(cylindersResponse.statusCode);
      throw Exception('error getting cylinders');
    }

    final reponse = jsonDecode(cylindersResponse.body);
    var cylinders = reponse["model"];
    List<Cylinder> cylinderList = [];
    for (var d in cylinders) {
      cylinderList.add(Cylinder.fromJson(d));
    }

    return cylinderList;
  }
}
