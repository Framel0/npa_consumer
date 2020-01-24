import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ConsumerProductEvent extends Equatable {
  ConsumerProductEvent([List<Object> props = const []]) : super(props);
}

class FetchConsumerProducts extends ConsumerProductEvent {
  final int userId;

  FetchConsumerProducts({@required this.userId});

  @override
  String toString() {
    return "Fetch Consumer Products";
  }
}
