import 'package:equatable/equatable.dart';

abstract class RequestRefillEvent extends Equatable {
  RequestRefillEvent([List props = const []]) : super(props);
}

class FetchApis extends RequestRefillEvent {
  @override
  String toString() {
    return "FetchApis";
  }
}
