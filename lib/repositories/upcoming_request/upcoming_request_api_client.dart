import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import 'package:npa_user/model/models.dart';

class UpcomingRequestApiClient {
  static const baseUrl = "http://173.248.135.167/NpaTest";
  final http.Client httpClient;

  UpcomingRequestApiClient({@required this.httpClient})
      : assert(httpClient != null);

  Future<List<UpcomingRequest>> fetchDealers() async {
    final upcomingRequestsUrl = "$baseUrl/api/DealerApi/Dealers";
    final upcomingRequestsResponse =
        await this.httpClient.get(upcomingRequestsUrl);

    if (upcomingRequestsResponse.statusCode != 200) {
      print(upcomingRequestsResponse.statusCode);
      throw Exception('error getting dealers');
    }

    final reponse = jsonDecode(upcomingRequestsResponse.body);
    var upcomingRequests = reponse["model"];
    List<UpcomingRequest> dealerList = [];
    // for (var d in dealers) {
    //   dealerList.add(UpcomingRequest.fromJson(d));
    // }

    return dealerList;
  }
}
