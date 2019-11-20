import 'package:flutter/material.dart';
import 'package:npa_user/widget/widget.dart';

class NewAddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Address"),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          children: <Widget>[
            NewAddressForm(),
          ],
        ),
      ),
    );
  }
}
