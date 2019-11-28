import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

abstract class RequestRefillEvent extends Equatable {
  RequestRefillEvent([List props = const []]) : super(props);
}

class FetchApis extends RequestRefillEvent {
  @override
  String toString() {
    return "FetchApis";
  }
}

class PostRefillRequest extends RequestRefillEvent {
  final RefillRequest refillRequest;

  PostRefillRequest({@required this.refillRequest});

  @override
  String toString() {
    return "PostRefillRequest";
  }
}
