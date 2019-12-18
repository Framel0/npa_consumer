import 'dart:async';
import 'package:bloc/bloc.dart';
import './add_new_address.dart';

class AddNewAddressBloc extends Bloc<AddNewAddressEvent, AddNewAddressState> {
  @override
  AddNewAddressState get initialState => AddNewAddressLoading();

  @override
  Stream<AddNewAddressState> mapEventToState(
    AddNewAddressEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
