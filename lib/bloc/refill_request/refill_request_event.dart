import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

abstract class RefillRequestEvent extends Equatable {
  RefillRequestEvent([List props = const []]) : super(props);
}

class FetchApis extends RefillRequestEvent {
  @override
  String toString() {
    return "FetchApis";
  }
}

class PostRefillRequest extends RefillRequestEvent {
  final RefillRequest refillRequest;

  PostRefillRequest({@required this.refillRequest});

  @override
  String toString() {
    return "PostRefillRequest";
  }
}

class ConfirmDelivery extends RefillRequestEvent {
  final int refillRequestId;

  ConfirmDelivery({
    @required this.refillRequestId,
  });

  @override
  String toString() {
    return "ConfirmDelivery";
  }
}
