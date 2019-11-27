import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

abstract class RequestRefillState extends Equatable {
  RequestRefillState([List props = const []]) : super(props);
}

class RequestRefillInitail extends RequestRefillState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "RequestRefillInitail";
  }
}

class RequestRefillLoading extends RequestRefillState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "RequestRefillLoading";
  }
}

class RequestRefillLoaded extends RequestRefillState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "RequestRefillLoaded";
  }
}

class RequestRefillError extends RequestRefillState {
  final String error;

  RequestRefillError({@required this.error});
  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return "RequestRefillError";
  }
}

class RequestRefillApiLoading extends RequestRefillState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "RequestRefillApiLoading";
  }
}

class RequestRefillApiLoaded extends RequestRefillState {
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
