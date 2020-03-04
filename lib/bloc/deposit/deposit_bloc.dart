import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/model/deposite.dart';

part 'deposit_event.dart';
part 'deposit_state.dart';

class DepositBloc extends Bloc<DepositEvent, DepositState> {
  @override
  DepositState get initialState => DepositInitial();

  @override
  Stream<DepositState> mapEventToState(
    DepositEvent event,
  ) async* {
    if (event is FetchDeposit) {
      yield DepositLoading();

      try {
        yield DepositLoaded();
      } catch (e) {
        yield DepositError(error: e.toString());
      }
    }
  }
}
