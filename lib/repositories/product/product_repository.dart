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

  List<ProductModel> getDropdownMenuItem() {
    List<ProductModel> items = List();

    for (Product district in _products) {}

    return items;
  }
}
