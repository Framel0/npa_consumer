import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DealerEvent extends Equatable {
  DealerEvent([List<dynamic> props = const []]) : super(props);
}

class FetchDealers extends DealerEvent {
  final int id;

  FetchDealers({@required this.id}) : super([id]);
  @override
  String toString() {
    return "FetchDealers";
  }
}
