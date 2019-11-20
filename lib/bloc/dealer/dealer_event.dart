import 'package:equatable/equatable.dart';

abstract class DealerEvent extends Equatable {
  DealerEvent([List<dynamic> props = const []]) : super(props);
}

class FetchDealers extends DealerEvent {
  // final int id;

  // FetchDealers(this.id) : super([id]);
  @override
  String toString() {
    return "FetchDealers";
  }
}
