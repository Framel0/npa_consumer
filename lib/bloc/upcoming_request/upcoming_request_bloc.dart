import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/repositories/upcoming_request/upcoming_request.dart';
import './upcoming_request.dart';

class UpcomingRequestBloc
    extends Bloc<UpcomingRequestEvent, UpcomingRequestState> {
  final UpcomingRequestRepository upcomingRequestRepository;

  UpcomingRequestBloc({@required this.upcomingRequestRepository});
  @override
  UpcomingRequestState get initialState => UpcomingRequestLoading();

  @override
  Stream<UpcomingRequestState> mapEventToState(
    UpcomingRequestEvent event,
  ) async* {
    if (event is FetchUpcomingRequests) {}
  }
}
