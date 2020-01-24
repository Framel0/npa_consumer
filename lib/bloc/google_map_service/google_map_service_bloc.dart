import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/repositories/google_map_service/google_map_service.dart';
import './google_map_service.dart';

class GoogleMapServiceBloc
    extends Bloc<GoogleMapServiceEvent, GoogleMapServiceState> {
  final GoogleMapServiceRepository googleMapServiceRepository;

  GoogleMapServiceBloc({@required this.googleMapServiceRepository})
      : assert(googleMapServiceRepository != null);
  @override
  GoogleMapServiceState get initialState => GoogleMapServiceInitial();

  @override
  Stream<GoogleMapServiceState> mapEventToState(
    GoogleMapServiceEvent event,
  ) async* {
    if (event is SendRequest) {
      yield GoogleMapServiceLoading();

      try {
        final lines = await googleMapServiceRepository.getRouteCoordinates(
            origin: event.origin, destination: event.distination);
        yield GoogleMapServiceLoaded(polylines: lines);
      } catch (e) {
        yield GoogleMapServiceError();
      }
    }
  }
}
