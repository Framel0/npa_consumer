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

  @override
  void initState() {
    super.initState();

    _firebaseListener();
  }

  _firebaseListener() {
    DatabaseHelper.instance.deleteAll();
    if (Platform.isIOS) {
      _firebaseMessaging.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, alert: true, badge: true));
    }
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message["notification"];
        final title = notification["title"];
        final body = notification["body"];
        _setMessage(title: title, body: body);
      },
    );
  }

  void _setMessage({@required title, @required body}) {
    var now = new DateTime.now();
    String date =
        ('${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}');
    var id = int.parse(date);
    setState(() {
      DatabaseHelper.instance.insert(Message(
        id: id,
        title: title,
        body: body,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notification"),
        ),
        body: FutureBuilder(
            future: DatabaseHelper.instance.queryAllMessages(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _buildMessageList(snapshot.data);
              } else {
                return Center(
                  child: Text("No Notification Available"),
                );
              }
            }));
  }

  Widget _buildMessageListItem(int position, Message message) {
    return ListTile(
      title: Text(message.title),
      subtitle: Text(message.body),
      trailing: IconButton(
        onPressed: () {
          DatabaseHelper.instance.delete(message.id);
          setState(() {});
        },
        icon: Icon(
          Icons.delete,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildMessageList(List<Message> messages) {
    return messages.isEmpty
        ? Center(
            child: Text("No Notification Available"),
          )
        : ListView.separated(
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
