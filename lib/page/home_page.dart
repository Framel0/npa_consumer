import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:npa_user/data/consumer_info.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/page/pages.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/drawer.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  User user;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        //  _showItemDialog(message);
      },
      //  onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        //  _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        //  _navigateToItemDetail(message);
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));

    readUserData().then((value) {
      setState(() {
        user = value;
      });
    });
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
                              if (user.statusId == 1) {
                                _showSnackbar(mContext: context);
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SafetyTipPage()),
                            );
                          }),
                      _buildItem(
                        icon: Icons.notifications,
                        text: "Notification",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
      }),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _showSnackbar({BuildContext mContext}) {
    final snackBar = SnackBar(
      content: Text('Please Confirm Deposite with Dealer',
          style: TextStyle(
            color: Colors.white,
          )),
      backgroundColor: Colors.redAccent,
      elevation: 10,
    );

    Scaffold.of(mContext).showSnackBar(snackBar);
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
          color: colorPrimaryYellow,
          child: InkWell(
            splashColor: Colors.indigo,
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
