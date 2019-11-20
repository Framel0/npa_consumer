import 'package:flutter/material.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widget.dart';

class AddressesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Addresses"),
      ),
      body: ListView(
        children: <Widget>[
          AddressList(),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width,
            child: OutlineButton(
              shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
              ),
              borderSide: BorderSide(color: colorAccentYellow, width: 2),
              padding: EdgeInsets.symmetric(vertical: 14.0),
              child: Text(
                "Add new Address",
                style: TextStyle(
                    color: colorPrimary,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pushNamed(context, newAddressRoute);
              },
            ),
          ),
        ],
      ),
    );
  }
}
