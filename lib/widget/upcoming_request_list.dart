import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widgets.dart';

class UpcomingRequestList extends StatefulWidget {
  @override
  _UpcomingRequestListState createState() => _UpcomingRequestListState();
}

class _UpcomingRequestListState extends State<UpcomingRequestList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget _buildUpcomingOrderItems(
      BuildContext context, int position, UpcomingRequest upcomingOrder) {
    return UpcomingRequestListItem(
      upcomingRequest: upcomingOrder,
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
          color: colorSecondaryOrange,
        );
      },
    );
  }
}
