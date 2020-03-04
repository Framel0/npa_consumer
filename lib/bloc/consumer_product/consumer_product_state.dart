import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/model/consumer_product.dart';
import 'package:npa_user/model/models.dart';

abstract class ConsumerProductState extends Equatable {
  ConsumerProductState([List<Object> props = const []]) : super(props);

  @override
  List<Object> get props => [];
}

class ConsumerProductLoading extends ConsumerProductState {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return "ConsumerProductLoading";
  }
}

class ConsumerProductLoaded extends ConsumerProductState {
  final List<ConsumerProduct> consumerProducts;

  ConsumerProductLoaded({@required this.consumerProducts});
  @override
  List<Object> get props => [consumerProducts];
  @override
  String toString() {
    return "ConsumerProductLoaded";
  }
}

class ConsumerProductError extends ConsumerProductState {
  final String error;

  ConsumerProductError({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() {
    return "ConsumerProductError";
  }
}

class AddNewConsumerProductLoading extends ConsumerProductState {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return "AddNewConsumerProductLoading";
  }
}

class AddNewConsumerProductSuccess extends ConsumerProductState {
  @override
  String toString() {
    return "AddNewConsumerProductSuccess";
  }
}

class AddNewConsumerProductError extends ConsumerProductState {
  final String error;

  AddNewConsumerProductError({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() {
    return "AddNewConsumerProductError";
  }
}

class AddNewConsumerProductApiLoading extends ConsumerProductState {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return "AddNewConsumerProductApiLoading";
  }
}

class AddNewConsumerProductApiLoaded extends ConsumerProductState {
  final List<Product> products;
  final List<Deposite> deposits;

  AddNewConsumerProductApiLoaded({
    @required this.products,
    @required this.deposits,
  });

  @override
  String toString() {
    return "AddNewConsumerProductApiLoaded";
  }
}

class AddNewConsumerProductApiError extends ConsumerProductState {
  final String error;

  AddNewConsumerProductApiError({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() {
    return "AddNewConsumerProductApiError";
  }
}
