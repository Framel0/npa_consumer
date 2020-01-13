import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

abstract class RefillRequestState extends Equatable {
  RefillRequestState([List props = const []]) : super(props);
}

class RequestRefillInitial extends RefillRequestState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "RequestRefillInitial";
  }
}

class RequestRefillLoading extends RefillRequestState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "RequestRefillLoading";
  }
}

class RequestRefillLoaded extends RefillRequestState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "RequestRefillLoaded";
  }
}

class RequestRefillError extends RefillRequestState {
  final String error;

  RequestRefillError({@required this.error});
  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return "RequestRefillError";
  }
}

class RequestRefillSuccess extends RefillRequestState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "RequestRefillSuccess";
  }
}

class RequestRefillApiLoading extends RefillRequestState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "RequestRefillApiLoading";
  }
}

class RequestRefillApiLoaded extends RefillRequestState {
  final List<Product> products;
  final List<PaymentMethod> paymentMethods;
  final List<DeliveryMethod> deliveryMethods;

  RequestRefillApiLoaded(
      {@required this.products,
      @required this.paymentMethods,
      @required this.deliveryMethods});

  @override
  List<Object> get props => [products, paymentMethods, deliveryMethods];

  @override
  String toString() {
    return "RequestRefillApiLoaded";
  }
}

class ConfirmDeliveryLoading extends RefillRequestState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "ConfirmDeliveryLoading";
  }
}

class ConfirmDeliverySuccess extends RefillRequestState {
  @override
  String toString() {
    return "ConfirmDeliverySuccess";
  }
}

class ConfirmDeliveryError extends RefillRequestState {
  final String error;

  ConfirmDeliveryError({@required this.error});
  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return "ConfirmDeliveryError";
  }
}
