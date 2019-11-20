import 'package:flutter/material.dart';
import 'package:npa_user/page/complaint_page.dart';
import 'package:npa_user/page/history_page.dart';
import 'package:npa_user/page/request_page.dart';
import 'package:npa_user/page/safety_tip_page.dart';
import 'package:npa_user/page/services_page.dart';
import 'package:npa_user/page/upcoming_order_page.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/drawer.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cylinder Distribution Platform',
        ),
      ),
      drawer: AppDrawer(),
      // backgroundColor: Colors.yellowAccent,
      body: SafeArea(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RequestPage()),
                            );
                          }),
                      _buildItem(
                          icon: Icons.event_note,
                          text: "Upcoming Order",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpcomingOrderPage()),
                            );
                          }),
                      _buildItem(
                          icon: Icons.history,
                          text: "Order History",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HistoryPage()),
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
      )),

      // This trailing comma makes auto-formatting nicer for build methods.
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
