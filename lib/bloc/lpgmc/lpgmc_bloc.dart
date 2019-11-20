import 'dart:async';
import 'package:bloc/bloc.dart';
import './lpgmc.dart';

class LpgmcBloc extends Bloc<LpgmcEvent, LpgmcState> {
  @override
  LpgmcState get initialState => InitialLpgmcState();

  @override
  Stream<LpgmcState> mapEventToState(
    LpgmcEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
