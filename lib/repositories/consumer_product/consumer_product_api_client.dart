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

  Future<List<ConsumerProduct>> fetchConsumerProducts(
      {@required int userId}) async {
    final consumerProductsUrl =
        "$baseUrl/api/ConsumerProductApi/ConsumerProductByConsumer/$userId";
    final consumerProductsResponse =
        await this.httpClient.get(consumerProductsUrl);

    if (consumerProductsResponse.statusCode != 200) {
      print(consumerProductsResponse.statusCode);
      throw Exception('error getting consumerProducts');
    }

    final reponse = jsonDecode(consumerProductsResponse.body);
    List<ConsumerProduct> consumerProductList = [];
    for (var p in reponse) {
      consumerProductList.add(ConsumerProduct.fromJson(p));
    }

    return consumerProductList;
  }
}
