import 'package:flutter/material.dart';
import 'package:npa_user/model/address.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/values/color.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Address address;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, profileEditRoute);
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        children: <Widget>[
          _buildListItem(title: "Consumer ID", subtitle: "NPAC-147852"),
          _divider(),
          _buildListItem(title: "Name", subtitle: "John Doe"),
          _divider(),
          _buildListItem(title: "Phone", subtitle: "+233 24 56 78 94"),
          _divider(),
          _buildListItem(title: "Delaer", subtitle: "ALO Gas"),
          SizedBox(
            height: 24,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: OutlineButton(
              shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
              ),
              borderSide: BorderSide(color: colorAccentYellow, width: 2),
              padding: EdgeInsets.symmetric(vertical: 14.0),
              child: Text(
                "Addresses",
                style: TextStyle(
                    color: colorPrimary,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pushNamed(context, addressesRoute);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 2,
      thickness: 1.5,
      color: colorAccentYellow,
    );
  }

  Widget _buildListItem({@required String title, @required String subtitle}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            color: colorPrimary, fontSize: 18, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
