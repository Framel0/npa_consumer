import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/repositories/repositories.dart';
import './address.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository addressRepository;

  AddressBloc({@required this.addressRepository});
  @override
  AddressState get initialState => AddressLoading();

  @override
  Stream<AddressState> mapEventToState(
    AddressEvent event,
  ) async* {
    if (event is FetchAddresses) {
      yield AddressLoading();

      try {
        await addressRepository.getAddresses(id: event.id);
        final addresses = addressRepository.addresses;
        yield AddressLoaded(addresses: addresses);
      } catch (e) {
        yield AddressError(error: e.toString());
      }
    }
  }
}
