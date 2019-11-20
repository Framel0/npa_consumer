import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widget.dart';

class UpcomingOrderPage extends StatefulWidget {
  @override
  _UpcomingOrderPageState createState() => _UpcomingOrderPageState();
}

class _UpcomingOrderPageState extends State<UpcomingOrderPage> {
  List<UpcomingRequest> upcomingOrders = [
    UpcomingRequest(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upcoming Orders")),
      body: _buildUpcomingOrderList(upcomingOrders),
    );
  }

  Widget _buildUpcomingOrderItems(
      BuildContext context, int position, UpcomingRequest upcomingOrder) {
    return UpcomingOrderListItem(
      upcomingOrder: upcomingOrder,
    );
  }

  Widget _buildUpcomingOrderList(List<UpcomingRequest> upcomingOrders) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      itemBuilder: (BuildContext context, int index) {
        return _buildUpcomingOrderItems(context, index, upcomingOrders[index]);
      },
      itemCount: upcomingOrders.length,
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
