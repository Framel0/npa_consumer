import 'package:equatable/equatable.dart';

abstract class UpcomingRequestEvent extends Equatable {
  UpcomingRequestEvent([List<Object> props = const []]) : super(props);
}

class FetchUpcomingRequests extends UpcomingRequestEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "FetcherUpcomingRequest";
  }
}
