import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:npa_user/model/models.dart';

class ProductApiClient {
  static const baseUrl = "http://173.248.135.167/NpaTest";
  final http.Client httpClient;

  ProductApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Product>> fetchProducts() async {
    final productsUrl = "$baseUrl/api/ProductApi/Products";
    final productsResponse = await this.httpClient.get(productsUrl);

    if (productsResponse.statusCode != 200) {
      print(productsResponse.statusCode);
      throw Exception('error getting products');
    }

    final reponse = jsonDecode(productsResponse.body);
    var products = reponse["model"];
    List<Product> productList = [];
    for (var d in products) {
      productList.add(Product.fromJson(d));
    }

    return productList;
  }
}
