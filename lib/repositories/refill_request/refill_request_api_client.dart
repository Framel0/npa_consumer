import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

class RefillRequestApiClient {
  static const baseUrl = "http://173.248.135.167/Npa";
  final http.Client httpClient;

  RefillRequestApiClient({@required this.httpClient})
      : assert(httpClient != null);

  Future<void> fetchRefillRequests(
      {@required RefillRequest refillRequest}) async {
    final refillRequestsUrl = "$baseUrl/api/ConsumerRefillRequest/Create";
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(refillRequest.toJson());

    final refillRequestsResponse = await this
        .httpClient
        .post(refillRequestsUrl, headers: headers, body: body);

    if (refillRequestsResponse.statusCode != 200) {
      print(refillRequestsResponse.statusCode);
      throw Exception('error getting refillRequests');
    }
  }

  Future<void> confirmDelivery({
    @required int refillRequestId,
  }) async {
    final String consumerRefillRequestsUrl =
        "$baseUrl/api/ConsumerRefillRequest/ConfirmDelivery/$refillRequestId";
    Map<String, String> headers = {'Content-Type': 'application/json'};

    final consumerRefillRequestsResponse = await this.httpClient.put(
          consumerRefillRequestsUrl,
          headers: headers,
        );

    if (consumerRefillRequestsResponse.statusCode != 200) {
      print(consumerRefillRequestsResponse.statusCode);
      throw Exception('error getting consumerRefillRequests');
    }
  }

  Future<void> cancelRequest({
    @required int refillRequestId,
  }) async {
    final String consumerRefillRequestsUrl =
        "$baseUrl/api/ConsumerRefillRequest/CancelRequest/$refillRequestId";
    Map<String, String> headers = {'Content-Type': 'application/json'};

    final consumerRefillRequestsResponse = await this.httpClient.put(
          consumerRefillRequestsUrl,
          headers: headers,
        );

    if (consumerRefillRequestsResponse.statusCode != 200) {
      print(consumerRefillRequestsResponse.statusCode);

      var response = jsonDecode(consumerRefillRequestsResponse.body);
      var message = response["message"];

      throw Exception(message.toString());
    }
  }
}
