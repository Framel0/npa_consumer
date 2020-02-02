import 'package:flutter/material.dart';
import 'package:npa_user/page/complaint_page.dart';
import 'package:npa_user/values/color.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Report Issue",
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        children: <Widget>[
          _buildItem(text: "Dealer"),
          _divider(),
          _buildItem(text: "Distributor"),
          _divider(),
          _buildItem(text: "Others"),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 4,
      thickness: 2,
      color: colorSecondaryOrange,
    );
  }

  Widget _buildItem({String text}) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ComplaintPage()),
        );
      },
      title: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
      trailing: Icon(Icons.navigate_next),
    );
  }
}
