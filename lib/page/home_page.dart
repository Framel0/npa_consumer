import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:npa_user/data/consumer_info.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/page/pages.dart';
import 'package:npa_user/repositories/repositories.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/drawer.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  int userId;
  int userStatus;

  final UserRepository userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    _getuserInfo();

    _refreshUserInfo();

    _firebaseListener();

    _flutterLocalNotification();
  }

  _getuserInfo() async {
    await readUserData().then((value) {
      setState(() {
        var user = value;
        userId = user.id;
        userStatus = user.statusId;
      });
    });
  }

  _firebaseListener() {
    // DatabaseHelper.instance.deleteAll();
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
        _showNotification(title: title, body: body);
      },
      //  onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        final notification = message["data"];
        final title = notification["title"];
        final body = notification["body"];
        _setMessage(title: title, body: body);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        final notification = message["data"];
        final title = notification["title"];
        final body = notification["body"];
        _setMessage(title: title, body: body);
      },
    );

    Stream<String> fcmStream = _firebaseMessaging.onTokenRefresh;
    fcmStream.listen((token) {
      saveToken(token);
    });
  }

  void saveToken(String token) async {
    var user = await readUserData();
    userRepository.updateFirebaseToken(userId: user.id, firebaseToken: token);
  }

  void _setMessage({@required title, @required body}) {
    var now = new DateTime.now();
    String date =
        ('${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}');
    var id = int.parse(date);
    // setState(() {
    DatabaseHelper.instance.insert(NotificationMessage(
      id: id,
      title: title,
      body: body,
    ));
    // });
  }

  _refreshUserInfo() {
    Timer.periodic(Duration(seconds: 10), (timer) {
      print("Timer:${DateTime.now()}");
      if (userStatus != 2) {
        readUserData().then((value) {
          setState(() {
            var user = value;
            userId = user.id;
            userStatus = user.statusId;
          });
        });

        userRepository.getUserInfo(userId: userId);
        print("Get user Info:${DateTime.now()}");
        print("Status id:${userStatus}");
      }
    });
  }

  _flutterLocalNotification() {
    var initializationSettingsAndroid = new AndroidInitializationSettings(
      'launcher_icon',
    );
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
      initializationSettingsAndroid,
      initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  _showNotification({@required title, @required body}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cylinder Distribution Platform',
        ),
      ),
      drawer: AppDrawer(),
      body: Builder(builder: (context) {
        return SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: _screenHeight * 0.35,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/npa_logo.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              // width: MediaQuery.of(context).size.width,
              // decoration: BoxDecoration(color: Colors.indigo),
              // padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildItem(
                            icon: Icons.library_books,
                            text: "Request Refill",
                            onTap: () {
                              if (userStatus == 1) {
                                FlushbarHelper.createInformation(
                                    message:
                                        'Please Confirm Deposite with Dealer')
                                  ..show(context);
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RequestPage()),
                                );
                              }
                            }),
                        _buildItem(
                            icon: Icons.event_note,
                            text: "Upcoming Order",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpcomingRequestPage()),
                              );
                            }),
                        _buildItem(
                            icon: Icons.history,
                            text: "Order History",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RequestHistoryPage()),
                              );
                            }),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _buildItem(
                          icon: Icons.description,
                          text: "Report Issue",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ComplaintPage()),
                            );
                          }),
                      _buildItem(
                          icon: Icons.error,
                          text: "Safety Tips",
                          onTap: () {
                            Navigator.pushNamed(context, safetyTipRoute);
                          }),
                      _buildItem(
                          icon: Icons.notifications,
                          text: "Notification",
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              notificationRoute,
                            );
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
      }),
    );
  }

  Widget _buildItem({IconData icon, String text, GestureTapCallback onTap}) {
    return Container(
      width: 120,
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          elevation: 5,
          shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
          ),
          color: colorPrimaryLight,
          child: InkWell(
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 50,
                ),
                Padding(
                  // decoration: BoxDecoration(color: Colors.black38),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Text(
                    text != null ? text : "",
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.body2.copyWith(
                          color: Colors.white,
                          fontSize: 13.5,
                        ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
