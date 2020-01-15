import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';

class NotifiactionPage extends StatefulWidget {
  @override
  _NotifiactionPageState createState() => _NotifiactionPageState();
}

class _NotifiactionPageState extends State<NotifiactionPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();

    if (Platform.isIOS) {
      _firebaseMessaging.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, alert: true, badge: true));
    }
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message["notification"];
        setState(() {
          messages.add(Message(
            title: notification["title"],
            body: notification["body"],
          ));
        });
      },
      //  onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        final notification = message["notification"];
        setState(() {
          messages.add(Message.fromJson(notification));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        //  _navigateToItemDetail(message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notification"),
        ),
        body: _buildMessageList(messages));
  }

  Widget _buildMessageListItem(int position, Message message) {
    return ListTile(
      title: Text(message.title),
      subtitle: Text(message.body),
    );
  }

  Widget _buildMessageList(List<Message> messages) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildMessageListItem(index, messages[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(thickness: 2.0);
      },
    );
  }
}
