import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:npa_user/model/models.dart';

class LpgmcApiClient {
  static const baseUrl = "http://173.248.135.167/NpaTest";
  final http.Client httpClient;

  LpgmcApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Lpgmc>> fetchDealers() async {
    final dealersUrl = "$baseUrl/api/DealerApi/Dealers";
    final dealersResponse = await this.httpClient.get(dealersUrl);

    if (dealersResponse.statusCode != 200) {
      print(dealersResponse.statusCode);
      throw Exception('error getting dealers');
    }

    final reponse = jsonDecode(dealersResponse.body);
    var dealers = reponse["model"];
    List<Lpgmc> dealerList = [];
    // for (var d in dealers) {
    //   dealerList.add(Lpgmc.fromJson(d));
    // }

    return dealerList;
  }
}
