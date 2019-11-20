import 'package:flutter/material.dart';
import 'package:npa_user/model/history.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widget.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<History> histories = [
    History(
        date: "12/08/2019",
        deliveryMethod: "Home Delivery",
        paymentMethod: "Cash on Delivery",
        refillType: "45kg",
        orderNumber: "0123456"),
    History(
        date: "20/09/2019",
        deliveryMethod: "Home Delivery",
        paymentMethod: "Mobile Money",
        refillType: "45kg",
        orderNumber: "0123456"),
    History(
        date: "30/09/2019",
        deliveryMethod: "Pick Up",
        paymentMethod: "Mobile Money",
        refillType: "90kg",
        orderNumber: "0123456"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order History",
        ),
      ),
      body: _buildHistoryList(histories),
    );
  }

  Widget _buildHistoryItems(
      BuildContext context, int position, History history) {
    return HistoryListItem(history);
  }

  Widget _buildHistoryList(List<History> histories) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      itemBuilder: (BuildContext context, int index) {
        return _buildHistoryItems(context, index, histories[index]);
      },
      itemCount: histories.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 4,
          thickness: 2,
          color: colorAccentYellow,
        );
      },
    );
  }
}
