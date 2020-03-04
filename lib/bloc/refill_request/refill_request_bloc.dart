import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/repositories/repositories.dart';
import './refill_request.dart';

class RefillRequestBloc extends Bloc<RefillRequestEvent, RefillRequestState> {
  final ConsumerProductRepository consumerProductRepository;
  final PaymentMethodRepository paymentMethodRepository;
  final DeliveryMethodRepository deliveryMethodRepository;
  final RefillRequestRepository refillRequestRepository;

  RefillRequestBloc(
      {@required this.refillRequestRepository,
      @required this.consumerProductRepository,
      @required this.paymentMethodRepository,
      @required this.deliveryMethodRepository});

  @override
  RefillRequestState get initialState => RequestRefillInitial();

  @override
  Stream<RefillRequestState> mapEventToState(
    RefillRequestEvent event,
  ) async* {
    if (event is FetchApis) {
      yield RequestRefillApiLoading();

      try {
        await consumerProductRepository.getConsumerProducts(
            consumerId: event.consumerId);
        final consumerProducts =
            consumerProductRepository.consumerConsumerProducts;

        await paymentMethodRepository.getPaymentMethods();
        final paymentMethods = paymentMethodRepository.paymentMethods;

        await deliveryMethodRepository.getDeliveryMethods();
        final deliveryMethods = deliveryMethodRepository.deliveryMethods;

        yield RequestRefillApiLoaded(
            consumerProducts: consumerProducts,
            paymentMethods: paymentMethods,
            deliveryMethods: deliveryMethods);
      } catch (e) {
        yield RequestRefillApiError();
      }
    }

    if (event is PostRefillRequest) {
      yield RequestRefillLoading();

      try {
        await refillRequestRepository.refillRequest(
            refillRequest: event.refillRequest);
        yield RequestRefillSuccess();
      } catch (e) {
        yield RequestRefillError(error: e.toString());
      }
    }

    if (event is ConfirmDelivery) {
      yield ConfirmDeliveryLoading();

      try {
        await refillRequestRepository.confirmDelivery(
          refillRequestId: event.refillRequestId,
        );

        yield ConfirmDeliverySuccess();
      } catch (e) {
        yield ConfirmDeliveryError(error: e.toString());
      }
    }

    if (event is CancelRequest) {
      yield CancelRequestLoading();

      try {
        await refillRequestRepository.cancelRequest(
          refillRequestId: event.refillRequestId,
        );

        yield CancelRequestSuccess();
      } catch (e) {
        yield CancelRequestError(error: e.toString());
      }
    }
  }
}
