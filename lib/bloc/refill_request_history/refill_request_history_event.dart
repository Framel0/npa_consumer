import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RefillRequestHistoryEvent extends Equatable {
  RefillRequestHistoryEvent();
}

class FetchRefillRequestHistory extends RefillRequestHistoryEvent {
  final int userId;

  FetchRefillRequestHistory({@required this.userId});
  @override
  String toString() {
    return "FetchRefillRequestHistory";
  }
}
