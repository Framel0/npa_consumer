import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

abstract class ConsumerProductEvent extends Equatable {
  ConsumerProductEvent([List<Object> props = const []]) : super(props);
}

class FetchConsumerProducts extends ConsumerProductEvent {
  final int consumerId;

  FetchConsumerProducts({@required this.consumerId});

  @override
  String toString() {
    return "Fetch Consumer Products";
  }
}

class AddNewConsumerProducts extends ConsumerProductEvent {
  final AddNewCylinderRequest addNewCylinderRequest;

  AddNewConsumerProducts({@required this.addNewCylinderRequest});
  @override
  String toString() {
    return "Add New Consumer Products";
  }
}

class FetchAddNewConsumerApi extends ConsumerProductEvent {
  @override
  String toString() {
    return "FetchAddNewConsumerApi";
  }
}
