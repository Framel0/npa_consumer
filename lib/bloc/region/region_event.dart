import 'package:equatable/equatable.dart';

abstract class RegionEvent extends Equatable {
  RegionEvent([List<Object> props = const []]) : super(props);
}

class FetchRegions extends RegionEvent {
  @override
  String toString() {
    return "FetchRegions";
  }
}
