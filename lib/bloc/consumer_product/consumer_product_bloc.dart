import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/repositories/consumer_product/consumer_product.dart';
import './consumer_product.dart';

class ConsumerProductBloc
    extends Bloc<ConsumerProductEvent, ConsumerProductState> {
  final ConsumerProductRepository consumerProductRepository;

  ConsumerProductBloc({@required this.consumerProductRepository});
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
            userId: event.userId);
        final consumerConsumerProducts =
            consumerProductRepository.consumerConsumerProducts;
        yield ConsumerProductLoaded(consumerProducts: consumerConsumerProducts);
      } catch (e) {
        yield ConsumerProductError(error: e.toString());
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
