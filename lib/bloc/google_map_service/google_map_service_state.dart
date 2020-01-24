import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

abstract class GoogleMapServiceState extends Equatable {
  GoogleMapServiceState();
}

class GoogleMapServiceInitial extends GoogleMapServiceState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "GoogleMapServiceInitial";
  }
}

class GoogleMapServiceLoading extends GoogleMapServiceState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "GoogleMapServiceLoading";
  }
}

class GoogleMapServiceLoaded extends GoogleMapServiceState {
  final List<LatLng> polylines;

  GoogleMapServiceLoaded({@required this.polylines});

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "GoogleMapServiceLoaded";
  }
}

class GoogleMapServiceError extends GoogleMapServiceState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "GoogleMapServiceError";
  }
}
