import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:npa_user/model/consumer_product.dart';
import 'package:npa_user/model/models.dart';

class ConsumerProductApiClient {
  static const baseUrl = "http://173.248.135.167/Npa";
  final http.Client httpClient;

  ConsumerProductApiClient({@required this.httpClient})
      : assert(httpClient != null);

  Future<List<ConsumerProduct>> fetchConsumerProducts({
    @required int userId,
  }) async {
    final consumerProductsUrl =
        "$baseUrl/api/ConsumerProduct/ConsumerProductsByConsumer/$userId";
    final consumerProductsResponse =
        await this.httpClient.get(consumerProductsUrl);

    if (consumerProductsResponse.statusCode != 200) {
      print(consumerProductsResponse.statusCode);
      throw Exception('error getting consumerProducts');
    }

    final consumerProducts = jsonDecode(consumerProductsResponse.body);
    List<ConsumerProduct> consumerProductList = [];
    for (var p in consumerProducts) {
      consumerProductList.add(ConsumerProduct.fromJson(p));
    }

    return consumerProductList;
  }

  Future addNewConsumerProducts({
    @required AddNewCylinderRequest cylinderRequest,
  }) async {
    final consumerProductsUrl = "$baseUrl/api/ConsumerProduct/Create";
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(cylinderRequest.toJson());

    final consumerProductsResponse = await this.httpClient.post(
          consumerProductsUrl,
          headers: headers,
          body: body,
        );

    if (consumerProductsResponse.statusCode != 200) {
      print(consumerProductsResponse.statusCode);
      throw Exception('error getting consumerProducts');
    }
  }
}
