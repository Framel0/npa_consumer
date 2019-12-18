import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/model/request_product.dart';

class UpcomingOrderListItem extends StatelessWidget {
  final UpcomingRequest upcomingOrder;

  const UpcomingOrderListItem({Key key, @required this.upcomingOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // RichText(
          //   maxLines: 2,
          //   overflow: TextOverflow.ellipsis,
          //   text: TextSpan(
          //     style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16),
          //     children: <TextSpan>[
          //       TextSpan(
          //           text: 'Dealer: ',
          //           style: TextStyle(fontWeight: FontWeight.bold)),
          //       TextSpan(text: "Dealer 1"),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 2,
          // ),
          Text('Refill Type: ', style: TextStyle(fontWeight: FontWeight.bold)),
          _buildProducts(products: upcomingOrder.products, mContext: context),
          SizedBox(
            height: 2,
          ),
          Text('Delivery Method: ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text("${upcomingOrder.deliveryMethod}"),
          SizedBox(
            height: 2,
          ),
          Text('Payment Method: ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text("${upcomingOrder.paymentMethod}"),
        ],
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
