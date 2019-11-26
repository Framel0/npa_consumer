import 'package:npa_user/model/product.dart';

class ProductModel {
  int id;
  String name;
  double price;
  int quantity;

  ProductModel.fromProduct(Product product) {
    id = product.id;
    name = product.name;
    price = product.price;
    quantity = 0;
  }
}
