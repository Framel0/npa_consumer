import 'dart:async';
import 'package:bloc/bloc.dart';
import './address.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  @override
  AddressState get initialState => AddressLoading();

  @override
  Stream<AddressState> mapEventToState(
    AddressEvent event,
  ) async* {
    if (event is FetchAddresses) {
      yield AddressLoading();

      try {
        yield AddressLoaded();
      } catch (e) {
        yield AddressError(error: e.toString());
      }
    }
  }
}
