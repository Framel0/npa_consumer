import 'package:equatable/equatable.dart';

abstract class RequestRefillState extends Equatable {
  RequestRefillState();
}

class InitialRequestRefillState extends RequestRefillState {
  @override
  List<Object> get props => [];
}
