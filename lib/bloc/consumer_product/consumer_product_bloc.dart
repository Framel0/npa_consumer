import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/repositories/consumer_product/consumer_product.dart';
import 'package:npa_user/repositories/deposite/deposite.dart';
import 'package:npa_user/repositories/product/product.dart';
import './consumer_product.dart';

class ConsumerProductBloc
    extends Bloc<ConsumerProductEvent, ConsumerProductState> {
  final ConsumerProductRepository consumerProductRepository;
  final DepositeRepository depositeRepository;
  final ProductRepository productRepository;

  ConsumerProductBloc({
    @required this.depositeRepository,
    @required this.consumerProductRepository,
    @required this.productRepository,
  });

  @override
  ConsumerProductState get initialState => ConsumerProductLoading();

  @override
  Stream<ConsumerProductState> mapEventToState(
    ConsumerProductEvent event,
  ) async* {
    if (event is FetchConsumerProducts) {
      yield ConsumerProductLoading();

      try {
        await consumerProductRepository.getConsumerProducts(
            consumerId: event.consumerId);
        final consumerConsumerProducts =
            consumerProductRepository.consumerConsumerProducts;
        yield ConsumerProductLoaded(consumerProducts: consumerConsumerProducts);
      } catch (e) {
        yield ConsumerProductError(error: e.toString());
      }
    }

    if (event is FetchAddNewConsumerApi) {
      yield AddNewConsumerProductApiLoading();

      try {
        await productRepository.getProducts();
        final products = productRepository.products;

        await depositeRepository.getDeposites();
        final deposits = depositeRepository.deposites;

        yield AddNewConsumerProductApiLoaded(
          products: products,
          deposits: deposits,
        );
      } catch (e) {
        yield AddNewConsumerProductApiError(error: e.toString());
      }
    }

    if (event is AddNewConsumerProducts) {
      yield AddNewConsumerProductLoading();

      try {
        await consumerProductRepository.addNewConsumerProducts(
            cylinderRequest: event.addNewCylinderRequest);
        yield AddNewConsumerProductSuccess();
      } catch (e) {
        yield AddNewConsumerProductError(error: e.toString());
      }
    }
  }
}
