import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UpcomingRequestEvent extends Equatable {
  UpcomingRequestEvent([List<Object> props = const []]) : super(props);
}

class FetchUpcomingRequests extends UpcomingRequestEvent {
  final int userId;

  FetchUpcomingRequests({@required this.userId});
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "FetcherUpcomingRequest";
  }
}
