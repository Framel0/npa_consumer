import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/model/request_product.dart';
import 'package:npa_user/values/color.dart';

class RequestHistoryDetailPage extends StatelessWidget {
  final RequestHistory requestHistory;

  const RequestHistoryDetailPage({Key key, @required this.requestHistory})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final requestId = requestHistory.id ?? 0;
    final consumerCode = requestHistory.consumerCode ?? "";
    final consumerFirstName = requestHistory.firstName ?? "";
    final consumerLastName = requestHistory.lastName ?? "";
    final houseNumber = requestHistory.houseNumber ?? "";
    final streetName = requestHistory.streetName ?? "";
    final residentialAddress = requestHistory.residentialAddress ?? "";
    final deliveryMethodId = requestHistory.deliveryMethodId ?? 0;
    final deliveryMethodName = requestHistory.deliveryMethod ?? "";
    final paymentMethodId = requestHistory.paymentMethodId ?? 0;
    final paymentMethodName = requestHistory.paymentMethod ?? "";
    final dispatchCode = requestHistory.dispatchCode ?? "";
    final dispatchFirstName = requestHistory.dispatchFirstName ?? "";
    final dispatchLastName = requestHistory.dispatchLastName ?? "";
    final dispatchPhoneNumber = requestHistory.dispatchPhoneNumber ?? "";
    final statusId = requestHistory.statusId ?? 0;
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: <Widget>[
          _buildHeading(
            text: "Consumer",
          ),
          _buildItem(title: "Consumer Code", subtitle: "$consumerCode"),
          _space10(),
          _buildItem(
              title: "Name", subtitle: "$consumerFirstName $consumerLastName"),
          _space10(),
          _buildItem(
              title: "Address",
              subtitle: "$houseNumber, $streetName, $residentialAddress"),
          _space10(),
          _buildItem(title: "Delivery Method", subtitle: "$deliveryMethodName"),
          _space10(),
          _buildItem(title: "Payment Method", subtitle: "$paymentMethodName"),
          _space10(),
          Text('Refill Type',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: colorPrimary)),
          _buildProducts(products: requestHistory.products, mContext: context),
          _space15(),
          _buildHeading(
            text: "Dispatch",
          ),
          _space10(),
          _buildItem(title: "Dispatch Code", subtitle: "$dispatchCode"),
          _space10(),
          _buildItem(
              title: "Name", subtitle: "$dispatchFirstName $dispatchLastName"),
          _space10(),
          _buildItem(title: "Phone Number", subtitle: "$dispatchPhoneNumber"),
          _space10(),
        ],
      ),
    );
  }

  Widget _space10() {
    return SizedBox(
      height: 10,
    );
  }

  Widget _space15() {
    return SizedBox(
      height: 15,
    );
  }

  Widget _buildProducts(
      {List<RequestProduct> products, BuildContext mContext}) {
    List<Widget> widgets = List<Widget>();
    for (RequestProduct product in products) {
      widgets.add(
        Text("${product.size} x ${product.quantity}",
            style: TextStyle(
              fontSize: 16,
            )),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Text _buildHeading({@required String text}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: colorSecondaryOrange),
    );
  }

  Widget _buildItem({@required String title, String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: colorPrimary),
        ),
        Text(subtitle,
            style: TextStyle(
              fontSize: 16,
            )),
      ],
    );
  }
}
