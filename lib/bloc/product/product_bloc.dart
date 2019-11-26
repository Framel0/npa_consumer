import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/repositories/repositories.dart';
import './product.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({@required this.productRepository});
  @override
  ProductState get initialState => ProductLoading();

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is FetchProducts) {
      yield ProductLoading();

      try {
        await productRepository.getProducts();
        final products = productRepository.products;
        yield ProductLoaded(products: products);
      } catch (e) {
        yield ProductError(error: e.toString());
      }
    }
  }
}
