import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

class DealerApiClient {
  static const baseUrl = "http://173.248.135.167/Npa";
  final http.Client httpClient;

  DealerApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Dealer>> fetchDealers() async {
    final dealersUrl = "$baseUrl/api/Dealer/Dealers";
    final dealersResponse = await this.httpClient.get(dealersUrl);

    if (dealersResponse.statusCode != 200) {
      print(dealersResponse.statusCode);
      throw Exception('error getting dealers');
    }

    final dealers = jsonDecode(dealersResponse.body);
    List<Dealer> dealerList = [];
    for (var d in dealers) {
      dealerList.add(Dealer.fromJson(d));
    }

    return dealerList;
  }

  Future<List<Dealer>> fetchDealersByLpgmc({@required int lpgmcId}) async {
    final dealersUrl = "$baseUrl/api/Dealer/DealersByLpgmc/$lpgmcId";
    final dealersResponse = await this.httpClient.get(dealersUrl);

    if (dealersResponse.statusCode != 200) {
      print(dealersResponse.statusCode);
      throw Exception('error getting dealers');
    }

    final dealers = jsonDecode(dealersResponse.body);
    List<Dealer> dealerList = [];
    for (var d in dealers) {
      dealerList.add(Dealer.fromJson(d));
    }

    return dealerList;
  }
}
