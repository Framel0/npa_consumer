import 'package:flutter/material.dart';
import 'package:npa_user/util/text_input_util.dart';
import 'package:npa_user/widget/widgets.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        children: <Widget>[ProfileEditForm()],
      ),
    );
  }
}
