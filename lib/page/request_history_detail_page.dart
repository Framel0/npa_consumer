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
    final consumerFirstName = requestHistory.firstName ?? "";
    final consumerLastName = requestHistory.lastName ?? "";
    final houseNumber = requestHistory.houseNumber ?? "";
    final streetName = requestHistory.streetName ?? "";
    final residentialAddress = requestHistory.residentialAddress ?? "";
    final deliveryMethodId = requestHistory.deliveryMethodId ?? 0;
    final deliveryMethodName = requestHistory.deliveryMethod ?? "";
    final paymentMethodId = requestHistory.paymentMethodId ?? 0;
    final paymentMethodName = requestHistory.paymentMethod ?? "";
    final dispatchId = requestHistory.dispatchId ?? "";
    final dispatchFirstName = requestHistory.dispatchFirstName ?? "";
    final dispatchLastName = requestHistory.dispatchLastName ?? "";
    final dispatchPhoneNumber = requestHistory.dispatchPhoneNumber ?? "";
    final statusId = requestHistory.statusId ?? 0;
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: <Widget>[
          _buildItem(
              title: "Name", subtitle: "$consumerFirstName $consumerLastName"),
          _space(),
          _buildItem(
              title: "Address",
              subtitle: "$houseNumber, $streetName, $residentialAddress"),
          _space(),
          _buildItem(title: "Delivery Method", subtitle: "$deliveryMethodName"),
          _space(),
          _buildItem(title: "Payment Method", subtitle: "$paymentMethodName"),
          _space(),
          Text('Refill Type: ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: colorPrimary)),
          _buildProducts(products: requestHistory.products, mContext: context),
          _space(),
          _buildItem(
              title: "Dispatch",
              subtitle:
                  "$dispatchId \n$dispatchFirstName $dispatchLastName \n$dispatchPhoneNumber"),
          _space(),
        ],
      ),
    );
  }

  Widget _space() {
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

  Widget _buildItem({@required String title, String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: colorPrimary),
        ),
        Text(subtitle,
            style: TextStyle(
              fontSize: 16,
            )),
      ],
    );
  }
}
