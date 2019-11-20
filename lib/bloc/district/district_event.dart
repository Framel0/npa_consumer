import 'package:equatable/equatable.dart';

abstract class DistrictEvent extends Equatable {
  DistrictEvent([List props = const []]) : super(props);
}

class FetchDistricts extends DistrictEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return "FetchDistricts";
  }
}
