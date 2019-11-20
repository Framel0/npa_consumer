import 'package:equatable/equatable.dart';

abstract class LpgmcState extends Equatable {
  LpgmcState();
}

class InitialLpgmcState extends LpgmcState {
  @override
  List<Object> get props => [];
}
