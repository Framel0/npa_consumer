import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/product/product.dart';

class ProductRepository {
  final ProductApiClient productApiClient;
  List<Product> _products = [];

  ProductRepository({@required this.productApiClient});

  Future getProducts() async {
    _products = await productApiClient.fetchProducts();
  }

  List<Product> get products {
    return List.from(_products);
  }

  List<DropdownMenuItem<Product>> getDropdownMenuItems() {
    List<DropdownMenuItem<Product>> items = List();

    for (Product product in _products) {
      items.add(DropdownMenuItem(
        value: product,
        child: Text(product.name),
      ));
    }
    return items;
  }
}
