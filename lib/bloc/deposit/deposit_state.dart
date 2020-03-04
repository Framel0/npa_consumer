part of 'deposit_bloc.dart';

abstract class DepositState extends Equatable {
  DepositState();
}

class DepositInitial extends DepositState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "DepositInitial";
  }
}

class DepositLoading extends DepositState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "DepositLoading";
  }
}

class DepositLoaded extends DepositState {
  final List<Deposite> deposits;

  DepositLoaded({@required this.deposits});
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "DepositLoaded";
  }
}

class DepositError extends DepositState {
  final String error;

  DepositError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return "DepositInitial";
  }
}
