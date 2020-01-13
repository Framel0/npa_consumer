import 'package:flutter/material.dart';
import 'package:npa_user/model/history.dart';
import 'package:npa_user/model/request_product.dart';
import 'package:npa_user/routes/routes.dart';

class RequestHistoryListItem extends StatelessWidget {
  final RequestHistory history;
  RequestHistoryListItem(this.history);
  @override
  Widget build(BuildContext context) {
    final firstName = history.firstName ?? "";
    final lastName = history.lastName ?? "";
    final deliveryMethod = history.deliveryMethod ?? "";
    final paymentMethod = history.paymentMethod ?? "";

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, requestHistoryDetailRoute,
            arguments: history);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Refill Type: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            _buildProducts(products: history.products, mContext: context),
            SizedBox(
              height: 2,
            ),
            Text('Delivery Method: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(deliveryMethod),
            SizedBox(
              height: 2,
            ),
            Text('Payment Method: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(paymentMethod),
          ],
        ),
      ),
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
