import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:npa_user/model/models.dart';

class DepositeApiClient {
  static const baseUrl = "http://173.248.135.167/Npa";
  final http.Client httpClient;

  DepositeApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Deposite>> fetchDeposites() async {
    final depositesUrl = "$baseUrl/api/DepositeApi/Deposites";
    final depositesResponse = await this.httpClient.get(depositesUrl);

    if (depositesResponse.statusCode != 200) {
      print(depositesResponse.statusCode);
      throw Exception('error getting deposites');
    }

    final reponse = jsonDecode(depositesResponse.body);
    var deposites = reponse["model"];
    List<Deposite> depositeList = [];
    for (var d in deposites) {
      depositeList.add(Deposite.fromJson(d));
    }

    return depositeList;
  }
}
