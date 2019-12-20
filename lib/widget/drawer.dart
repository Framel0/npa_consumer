import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/authentication/authentication.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:npa_user/data/consumer_info.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/page/contact_us_page.dart';
import 'package:npa_user/page/home_page.dart';
import 'package:npa_user/page/profile_page.dart';
import 'package:npa_user/page/safety_tip_page.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/values/color.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var user = User();

  @override
  void initState() {
    super.initState();

    readUserData().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final String firstName = user.firstName ?? "";
    final String lastName = user.lastName ?? "";
    final String phoneNumber = user.phoneNumber ?? "";
    final String consumerId = user.consumerId ?? "";
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              firstName: firstName,
              lastName: lastName,
              phoneNumber: phoneNumber),
          _createDrawerItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
          _createDrawerItem(
            icon: Icons.error,
            text: 'Safety Tips',
            onTap: () {
              // Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SafetyTipPage()),
              );
            },
          ),
          _createDrawerItem(
              icon: Icons.exit_to_app,
              text: 'Logout',
              onTap: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .dispatch(LoggedOut());
                Navigator.pushNamedAndRemoveUntil(
                    context, landingRoute, (Route<dynamic> route) => false);
              }),
          _createDrawerItem(icon: Icons.notifications, text: 'Notification'),
          _createDrawerItem(
            icon: Icons.phone,
            text: 'Contact Us',
            onTap: () {
              // Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _createHeader(
      {GestureTapCallback onTap,
      @required String firstName,
      @required String lastName,
      @required String phoneNumber}) {
    return UserAccountsDrawerHeader(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(color: colorPrimary),
      accountName: InkWell(
        onTap: onTap,
        child: Text(
          "$firstName $lastName",
          style: TextStyle(color: colorAccentYellow),
        ),
      ),
      accountEmail: Text(
        phoneNumber,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
