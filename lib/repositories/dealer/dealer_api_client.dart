import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

class DealerApiClient {
  static const baseUrl = "http://173.248.135.167/Npa";
  final http.Client httpClient;

  DealerApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Dealer>> fetchDealers() async {
    final dealersUrl = "$baseUrl/api/DealerApi/Dealers";
    final dealersResponse = await this.httpClient.get(dealersUrl);

    if (dealersResponse.statusCode != 200) {
      print(dealersResponse.statusCode);
      throw Exception('error getting dealers');
    }

    final reponse = jsonDecode(dealersResponse.body);
    var dealers = reponse["model"];
    List<Dealer> dealerList = [];
    for (var d in dealers) {
      dealerList.add(Dealer.fromJson(d));
    }

    return dealerList;
  }

  Future<List<Dealer>> fetchDealersByLpgmc(int id) async {
    final dealersUrl = "$baseUrl/api/DealerApi/DealersByLpgmc/$id";
    final dealersResponse = await this.httpClient.get(dealersUrl);

    if (dealersResponse.statusCode != 200) {
      print(dealersResponse.statusCode);
      throw Exception('error getting dealers');
    }

    final reponse = jsonDecode(dealersResponse.body);
    var dealers = reponse["model"];
    List<Dealer> dealerList = [];
    for (var d in dealers) {
      dealerList.add(Dealer.fromJson(d));
    }

    return dealerList;
  }
}
