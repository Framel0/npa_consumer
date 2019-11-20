import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class CounterEvent extends Equatable {
  CounterEvent([List props = const []]) : super(props);
}

class IncreaseQuantity3kg extends CounterEvent {
  @override
  String toString() {
    return "Increament";
  }
}

class DecreseQuantity3kg extends CounterEvent {
  @override
  String toString() {
    return "Increament";
  }
}
