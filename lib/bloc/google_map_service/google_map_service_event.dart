import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

abstract class GoogleMapServiceEvent extends Equatable {
  GoogleMapServiceEvent();
}

class SendRequest extends GoogleMapServiceEvent {
  final LatLng origin;
  final LatLng distination;

  SendRequest({@required this.origin, @required this.distination});
  @override
  String toString() {
    return "SendRequest";
  }
}
