import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

abstract class ProductState extends Equatable {
  ProductState([List<Object> props = const []]) : super(props);

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return "ProductLoading";
  }
}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded({@required this.products});
  @override
  List<Object> get props => [products];
  @override
  String toString() {
    return "ProductLoaded";
  }
}

class ProductError extends ProductState {
  final String error;

  ProductError({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() {
    return "ProductError";
  }
}
