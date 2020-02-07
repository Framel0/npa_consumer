import 'package:flutter/material.dart';
import 'package:npa_user/model/request_history.dart';
import 'package:npa_user/model/request_product.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/values/color.dart';

class RequestHistoryListItem extends StatelessWidget {
  final RequestHistory history;
  RequestHistoryListItem(this.history);
  @override
  Widget build(BuildContext context) {
    final firstName = history.firstName ?? "";
    final lastName = history.lastName ?? "";
    final deliveryMethod = history.deliveryMethod ?? "";
    final paymentMethod = history.paymentMethod ?? "";
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, requestHistoryDetailRoute,
            arguments: history);
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
