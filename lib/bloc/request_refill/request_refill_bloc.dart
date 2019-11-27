import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/repositories.dart';
import './request_refill.dart';

class RequestRefillBloc extends Bloc<RequestRefillEvent, RequestRefillState> {
  final ProductRepository productRepository;
  final PaymentMethodRepository paymentMethodRepository;
  final DeliveryMethodRepository deliveryMethodRepository;

  RequestRefillBloc(
      {@required this.productRepository,
      @required this.paymentMethodRepository,
      @required this.deliveryMethodRepository});

  @override
  RequestRefillState get initialState => RequestRefillInitail();

  @override
  Stream<RequestRefillState> mapEventToState(
    RequestRefillEvent event,
  ) async* {
    if (event is FetchApis) {
      yield RequestRefillApiLoading();

      try {
        await productRepository.getProducts();
        final products = productRepository.products;

        await paymentMethodRepository.getPaymentMethods();
        final paymentMethods = paymentMethodRepository.paymentMethods;

        await deliveryMethodRepository.getDeliveryMethods();
        final deliveryMethods = deliveryMethodRepository.deliveryMethods;

        yield RequestRefillApiLoaded(
            products: products,
            paymentMethods: paymentMethods,
            deliveryMethods: deliveryMethods);
      } catch (e) {
        yield RequestRefillError(error: e.toString());
      }
    }
  }
}
