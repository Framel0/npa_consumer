import 'dart:async';
import 'package:bloc/bloc.dart';
import './cylinder.dart';

class CylinderBloc extends Bloc<CylinderEvent, CylinderState> {
  @override
  CylinderState get initialState => InitialCylinderState();

  @override
  Stream<CylinderState> mapEventToState(
    CylinderEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
