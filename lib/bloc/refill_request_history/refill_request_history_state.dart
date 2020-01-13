import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

abstract class RefillRequestHistoryState extends Equatable {
  RefillRequestHistoryState();

  @override
  List<Object> get props => [];
}

class RefillRequestHistoryLoading extends RefillRequestHistoryState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "RefillRequestHistoryLoading";
  }
}

class RefillRequestHistoryLoaded extends RefillRequestHistoryState {
  final List<RequestHistory> histories;

  RefillRequestHistoryLoaded({@required this.histories});

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "RefillRequestHistoryLoaded";
  }
}

class RefillRequestHistoryError extends RefillRequestHistoryState {
  final String error;

  RefillRequestHistoryError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return "RefillRequestHistoryError";
  }
}
