import 'package:meta/meta.dart';

class Notification {
  final String title;
  final String body;

  Notification({
    @required this.title,
    @required this.body,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      title: json["title"],
      body: json["body"],
    );
  }
}
