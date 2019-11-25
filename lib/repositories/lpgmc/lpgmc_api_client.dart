import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:npa_user/model/models.dart';

class LpgmcApiClient {
  static const baseUrl = "http://173.248.135.167/NpaTest";
  final http.Client httpClient;

  LpgmcApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Lpgmc>> fetchLpgmcs() async {
    final lpgmcsUrl = "$baseUrl/api/LpgmcApi/Lpgmcs";
    final lpgmcsResponse = await this.httpClient.get(lpgmcsUrl);

    if (lpgmcsResponse.statusCode != 200) {
      print(lpgmcsResponse.statusCode);
      throw Exception('error getting lpgmcs');
    }

    final reponse = jsonDecode(lpgmcsResponse.body);
    var lpgmcs = reponse["model"];
    List<Lpgmc> lpgmcList = [];
    for (var l in lpgmcs) {
      lpgmcList.add(Lpgmc.fromJson(l));
    }

    return lpgmcList;
  }
}
