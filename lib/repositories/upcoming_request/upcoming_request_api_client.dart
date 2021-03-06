import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import 'package:npa_user/model/models.dart';

class UpcomingRequestApiClient {
  static const baseUrl = "http://173.248.135.167/Npa";
  final http.Client httpClient;

  UpcomingRequestApiClient({@required this.httpClient})
      : assert(httpClient != null);

  Future<List<UpcomingRequest>> fetchUpcomingRequests(
      {@required int consumerId}) async {
    final upcomingRequestsUrl =
        "$baseUrl/api/ConsumerRefillRequest/ConsumerRefillRequestsByConsumer/$consumerId";
    final upcomingRequestsResponse =
        await this.httpClient.get(upcomingRequestsUrl);

    if (upcomingRequestsResponse.statusCode != 200) {
      print(upcomingRequestsResponse.statusCode);
      throw Exception('error getting upcomingRequests');
    }

    final upcomingRequests = jsonDecode(upcomingRequestsResponse.body);

    List<UpcomingRequest> upcomingRequestList = [];
    for (var d in upcomingRequests) {
      upcomingRequestList.add(UpcomingRequest.fromJson(d));
    }

    return upcomingRequestList;
  }
}
