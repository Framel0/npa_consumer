import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

abstract class RegionState extends Equatable {
  RegionState([List<Object> props = const []]) : super(props);
}

class RegionLoading extends RegionState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "RegionLoading";
  }
}

class RegionLoaded extends RegionState {
  final List<Region> regions;

  RegionLoaded({@required this.regions});

  @override
  List<Object> get props => [regions];

  @override
  String toString() {
    return "RegionLoaded";
  }
}

class RegionError extends RegionState {
  final String error;

  RegionError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return "RegionError";
  }
}
