import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:npa_user/model/models.dart';

class ProductApiClient {
  static const baseUrl = "http://173.248.135.167/Npa";
  final http.Client httpClient;

  ProductApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Product>> fetchProducts() async {
    final productsUrl = "$baseUrl/api/Product/Products";
    final productsResponse = await this.httpClient.get(productsUrl);

    if (productsResponse.statusCode != 200) {
      print(productsResponse.statusCode);
      throw Exception('error getting products');
    }

    final products = jsonDecode(productsResponse.body);

    List<Product> productList = [];
    for (var d in products) {
      productList.add(Product.fromJson(d));
    }

    return productList;
  }
}
