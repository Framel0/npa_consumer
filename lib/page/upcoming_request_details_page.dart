import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/model/request_product.dart';
import 'package:npa_user/values/color.dart';

class UpcomingRequestDetailPage extends StatelessWidget {
  final UpcomingRequest upcomingRequest;

  const UpcomingRequestDetailPage({Key key, @required this.upcomingRequest})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final consumerFirstName = upcomingRequest.firstName ?? "";
    final consumerLastName = upcomingRequest.lastName ?? "";
    final houseNumber = upcomingRequest.houseNumber ?? "";
    final streetName = upcomingRequest.streetName ?? "";
    final residentialAddress = upcomingRequest.residentialAddress ?? "";
    final deliveryMethodId = upcomingRequest.deliveryMethodId ?? 0;
    final deliveryMethodName = upcomingRequest.deliveryMethod ?? "";
    final paymentMethodId = upcomingRequest.paymentMethodId ?? 0;
    final paymentMethodName = upcomingRequest.paymentMethod ?? "";
    final dispatchId = upcomingRequest.dispatchId ?? "";
    final dispatchFirstName = upcomingRequest.dispatchFirstName ?? "";
    final dispatchLastName = upcomingRequest.dispatchLastName ?? "";
    final dispatchPhoneNumber = upcomingRequest.dispatchPhoneNumber ?? "";
    final statusId = upcomingRequest.statusId ?? 0;
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
          _buildProducts(products: upcomingRequest.products, mContext: context),
          _space(),
          _buildBottom(
              context: context,
              deliveryMethodId: deliveryMethodId,
              statusId: statusId,
              dispatchId: dispatchId,
              dispatchFirstName: dispatchFirstName,
              dispatchLastName: dispatchLastName,
              dispatchPhoneNumber: dispatchPhoneNumber),
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

  _buildBottom({
    BuildContext context,
    @required int deliveryMethodId,
    @required int statusId,
    @required String dispatchId,
    @required String dispatchFirstName,
    @required String dispatchLastName,
    @required String dispatchPhoneNumber,
  }) {
    if (statusId == 2) {
      return Container();
    } else if (statusId == 3) {
      return _buildItem(
          title: "Dispatch to Deliver",
          subtitle:
              "$dispatchId \n$dispatchFirstName $dispatchLastName \n$dispatchPhoneNumber");
    } else {
      return Container();
    }
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
