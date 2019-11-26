import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  ProductEvent([List<Object> props = const []]) : super(props);
}

class FetchProducts extends ProductEvent {
  @override
  String toString() {
    return "Fetch Products";
  }
}
