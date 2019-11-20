import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CounterState extends Equatable {}

class InitialCounterState extends CounterState {}

class Increase extends CounterState {
  int quantity;
}
