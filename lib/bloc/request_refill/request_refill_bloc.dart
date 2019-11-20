import 'dart:async';
import 'package:bloc/bloc.dart';
import './request_refill.dart';

class RequestRefillBloc extends Bloc<RequestRefillEvent, RequestRefillState> {
  @override
  RequestRefillState get initialState => InitialRequestRefillState();

  @override
  Stream<RequestRefillState> mapEventToState(
    RequestRefillEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
