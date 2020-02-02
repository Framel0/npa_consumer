import 'package:flutter/material.dart';
import 'package:npa_user/values/color.dart';

class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Services")),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          children: <Widget>[
            _buildItem(Icons.home, "Address Change Request"),
            _divider(),
            _buildItem(Icons.call, "Mobile number Change Request"),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(
      thickness: 2,
      color: colorSecondaryOrange,
    );
  }

  Widget _buildItem(IconData icon, String title) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
      onTap: () {},
      leading: Icon(
        icon,
        size: 30,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.title.copyWith(fontSize: 17),
      ),
    );
  }
}
