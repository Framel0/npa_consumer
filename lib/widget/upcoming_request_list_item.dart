import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/model/request_product.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/values/color.dart';

class UpcomingRequestListItem extends StatelessWidget {
  final UpcomingRequest upcomingRequest;

  const UpcomingRequestListItem({Key key, @required this.upcomingRequest})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstName = upcomingRequest.firstName ?? "";
    final lastName = upcomingRequest.lastName ?? "";
    final deliveryMethod = upcomingRequest.deliveryMethod ?? "";
    final paymentMethod = upcomingRequest.paymentMethod ?? "";
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, upcomingRequestDetailRoute,
            arguments: upcomingRequest);
      },
      title: Text("Name: $firstName $lastName",
          style: Theme.of(context).textTheme.title.copyWith(
                color: colorPrimary,
              )),
      subtitle: Text(
          "DeliveryMethod: $deliveryMethod \nPaymentMethod: $paymentMethod",
          style: Theme.of(context).textTheme.subtitle.copyWith(
                color: colorPrimary,
              )),
      isThreeLine: true,
    );
  }

  Widget _buildProducts(
      {List<RequestProduct> products, BuildContext mContext}) {
    List<Widget> widgets = List<Widget>();
    for (RequestProduct product in products) {
      widgets.add(
        Text("${product.size} x ${product.quantity}"),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
