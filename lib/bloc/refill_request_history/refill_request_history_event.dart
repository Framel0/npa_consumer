import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RefillRequestHistoryEvent extends Equatable {
  RefillRequestHistoryEvent();
}

class FetchRefillRequestHistory extends RefillRequestHistoryEvent {
  final int consumerId;

  FetchRefillRequestHistory({@required this.consumerId});
  @override
  String toString() {
    return "FetchRefillRequestHistory";
  }
}
