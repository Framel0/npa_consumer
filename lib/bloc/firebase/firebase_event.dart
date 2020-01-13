import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class FirebaseEvent extends Equatable {
  FirebaseEvent();
}

class SendNotification extends FirebaseEvent {
  final String title;
  final String body;
  final String token;

  SendNotification(
      {@required this.title, @required this.body, @required this.token});

  @override
  String toString() {
    return "Send Notification";
  }
}
