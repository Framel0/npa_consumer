import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

abstract class UpcomingRequestState extends Equatable {
  UpcomingRequestState([List<Object> props = const []]) : super(props);
}

class UpcomingRequestLoading extends UpcomingRequestState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "UpcomingRequestLoading";
  }
}

class UpcomingRequestLoaded extends UpcomingRequestState {
  final List<UpcomingRequest> upcomingRequests;

  UpcomingRequestLoaded({@required this.upcomingRequests});

  @override
  List<Object> get props => [upcomingRequests];

  @override
  String toString() {
    return "UpcomingRequestLoaded";
  }
}

class UpcomingRequestError extends UpcomingRequestState {
  final String error;

  UpcomingRequestError({@required this.error});
  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return "UpcomingRequestError";
  }
}
