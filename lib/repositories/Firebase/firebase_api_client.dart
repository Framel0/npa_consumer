import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class FirebaseApiClient {
  static const baseUrl = "https://fcm.googleapis.com/fcm/send";
  static const serverKey =
      "AAAAIuX_veM:APA91bEN_7Od89xo5vhx7T0k0SRB7CU9azIdG7k7uZD52URUIFrObKcnJXYS-wcETxzacC6cyk531Cj8iDk8sRahX62657l2WxeJr7CfBg4Z93yhgJMtovF4qHbrX23w0CFz3w_K6Lzw";

  final http.Client httpClient;

  FirebaseApiClient({@required this.httpClient});

  Future sendNotification(
      {@required String title,
      @required String body,
      @required String token}) async {
    final data = {
      "notification": {"title": "$title", "body": "$body"},
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
      "to": "$token"
    };
    final headers = {
      'content-type': 'application/json',
      'Authorization': serverKey
    };

    final response = await http.post(baseUrl,
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      print("Notification sent !");
    } else {
      print("Notification not sent!");
    }
  }
}
