import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

class RefillRequestHistoryApiClient {
  static const baseUrl = "http://173.248.135.167/Npa";
  final http.Client httpClient;

  RefillRequestHistoryApiClient({@required this.httpClient})
      : assert(httpClient != null);

  Future<List<RequestHistory>> fetchRefillRequestHistorys(
      {@required int userId}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final refillRequestHistorysUrl =
        "$baseUrl/api/ConsumerRefillRequestApi/ConsumerRefillRequestsByConsumerHistory/$userId";

    final refillRequestHistorysResponse =
        await this.httpClient.get(refillRequestHistorysUrl, headers: headers);

    if (refillRequestHistorysResponse.statusCode != 200) {
      print(refillRequestHistorysResponse.statusCode);
      throw Exception('error getting refillRequestHistorys');
    }

    final reponse = jsonDecode(refillRequestHistorysResponse.body);
    var requestHistory = reponse["model"];
    List<RequestHistory> requestHistoryList = [];
    for (var d in requestHistory) {
      requestHistoryList.add(RequestHistory.fromJson(d));
    }

    return requestHistoryList;
  }
}
