import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/authentication/authentication.dart';
import 'package:npa_user/bloc/bloc.dart';
import 'package:npa_user/page/contact_us_page.dart';
import 'package:npa_user/page/home_page.dart';
import 'package:npa_user/page/profile_page.dart';
import 'package:npa_user/page/safety_tip_page.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/values/color.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
          }),
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

  Widget _createHeader({GestureTapCallback onTap}) {
    return UserAccountsDrawerHeader(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(color: colorPrimary),
      accountName: InkWell(
        onTap: onTap,
        child: Text(
          "John Doe",
          style: TextStyle(color: colorAccentYellow),
        ),
      ),
      accountEmail: Text(
        "02314567",
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
