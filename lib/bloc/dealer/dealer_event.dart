import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DealerEvent extends Equatable {
  DealerEvent([List<dynamic> props = const []]) : super(props);
}

class FetchDealers extends DealerEvent {
  final int lpgmcId;

  FetchDealers({@required this.lpgmcId}) : super([lpgmcId]);
  @override
  String toString() {
    return "FetchDealers";
  }
}
