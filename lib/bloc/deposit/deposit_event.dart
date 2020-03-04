part of 'deposit_bloc.dart';

abstract class DepositEvent extends Equatable {
  DepositEvent();
}

class FetchDeposit extends DepositEvent {}
