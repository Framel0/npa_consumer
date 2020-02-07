import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:npa_user/model/models.dart';

class LpgmcApiClient {
  static const baseUrl = "http://173.248.135.167/Npa";
  final http.Client httpClient;

  LpgmcApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Lpgmc>> fetchLpgmcs() async {
    final lpgmcsUrl = "$baseUrl/api/Lpgmc/Lpgmcs";
    final lpgmcsResponse = await this.httpClient.get(lpgmcsUrl);

    if (lpgmcsResponse.statusCode != 200) {
      print(lpgmcsResponse.statusCode);
      throw Exception('error getting lpgmcs');
    }

    final lpgmcs = jsonDecode(lpgmcsResponse.body);

    List<Lpgmc> lpgmcList = [];
    for (var l in lpgmcs) {
      lpgmcList.add(Lpgmc.fromJson(l));
    }

    return lpgmcList;
  }
}
