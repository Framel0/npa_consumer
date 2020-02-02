import 'package:flutter/material.dart';
import 'package:npa_user/data/consumer_info.dart';
import 'package:npa_user/model/address.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/values/color.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var user = User();
  Address address;

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
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final String firstName = user.firstName ?? "";
    final String lastName = user.lastName ?? "";
    final String phoneNumber = user.phoneNumber ?? "";
    final String consumerId = user.consumerId ?? "";

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
          _buildListItem(title: "Consumer ID", subtitle: consumerId),
          _divider(),
          _buildListItem(title: "Name", subtitle: "${firstName} ${lastName}"),
          _divider(),
          _buildListItem(title: "Phone", subtitle: phoneNumber),
          SizedBox(
            height: 24,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: OutlineButton(
              shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
              ),
              borderSide: BorderSide(color: colorSecondaryOrange, width: 2),
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
      color: colorSecondaryOrange,
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
