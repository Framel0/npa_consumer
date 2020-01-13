import 'package:flutter/material.dart';
import 'package:npa_user/widget/widgets.dart';

class RequestHistoryPage extends StatefulWidget {
  @override
  _RequestHistoryPageState createState() => _RequestHistoryPageState();
}

class _RequestHistoryPageState extends State<RequestHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order History",
        ),
      ),
      body: RequestHistoryList(),
    );
  }
}
