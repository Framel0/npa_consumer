import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/model/request_product.dart';

class UpcomingOrderListItem extends StatelessWidget {
  final UpcomingRequest upcomingOrder;

  const UpcomingOrderListItem({Key key, @required this.upcomingOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final consumerFirstName = upcomingOrder.firstName ?? "";
    final consumerLastName = upcomingOrder.lastName ?? "";
    final deliveryMethod = upcomingOrder.deliveryMethod ?? "";
    final paymentMethod = upcomingOrder.paymentMethod ?? "";

    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Refill Type: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            _buildProducts(products: upcomingOrder.products, mContext: context),
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
