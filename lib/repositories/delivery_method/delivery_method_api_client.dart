import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

class DeliveryMethodApiClient {
  static const baseUrl = "http://173.248.135.167/Npa";
  final http.Client httpClient;

  DeliveryMethodApiClient({@required this.httpClient})
      : assert(httpClient != null);

  Future<List<DeliveryMethod>> fetchDeliveryMethods() async {
    final deliveryMethodsUrl = "$baseUrl/api/DeliveryMethodApi/DeliveryMethods";
    final deliveryMethodsResponse =
        await this.httpClient.get(deliveryMethodsUrl);

    if (deliveryMethodsResponse.statusCode != 200) {
      print(deliveryMethodsResponse.statusCode);
      throw Exception('error getting deliveryMethods');
    }

    final reponse = jsonDecode(deliveryMethodsResponse.body);
    var deliveryMethods = reponse["model"];
    List<DeliveryMethod> deliveryMethodList = [];

    for (var d in deliveryMethods) {
      deliveryMethodList.add(DeliveryMethod.fromJson(d));
    }

    return deliveryMethodList;
  }
}
