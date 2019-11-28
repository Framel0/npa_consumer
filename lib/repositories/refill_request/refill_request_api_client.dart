import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

class RefillRequestApiClient {
  static const baseUrl = "http://173.248.135.167/NpaTest";
  final http.Client httpClient;

  RefillRequestApiClient({@required this.httpClient})
      : assert(httpClient != null);

  Future<void> fetchRefillRequests(
      {@required RefillRequest refillRequest}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final refillRequestsUrl = "$baseUrl/api/ConsumerRefillRequestApi/Create";
    final body = jsonEncode(refillRequest.toJson());

    final refillRequestsResponse = await this
        .httpClient
        .post(refillRequestsUrl, headers: headers, body: body);

    if (refillRequestsResponse.statusCode != 200) {
      print(refillRequestsResponse.statusCode);
      throw Exception('error getting refillRequests');
    }

    final reponse = jsonDecode(refillRequestsResponse.body);
  }
}
