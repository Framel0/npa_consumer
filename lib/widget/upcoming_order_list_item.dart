import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';

class UpcomingOrderListItem extends StatelessWidget {
  final UpcomingRequest upcomingOrder;

  const UpcomingOrderListItem({Key key, this.upcomingOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16),
              children: <TextSpan>[
                TextSpan(
                    text: 'Dealer: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: "Dealer 1"),
              ],
            ),
          ),
          SizedBox(
            height: 2,
          ),
          RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16),
              children: <TextSpan>[
                TextSpan(
                    text: 'Refill Type: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: "90 Kg"),
              ],
            ),
          ),
          SizedBox(
            height: 2,
          ),
          RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16),
              children: <TextSpan>[
                TextSpan(
                    text: 'Delivery Method: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: "Home Delivery"),
              ],
            ),
          ),
          SizedBox(
            height: 2,
          ),
          RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16),
              children: <TextSpan>[
                TextSpan(
                    text: 'Payment Method: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: "Cash on Delivery"),
              ],
            ),
          ),
          SizedBox(
            height: 2,
          ),
          RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16),
              children: <TextSpan>[
                TextSpan(
                    text: 'Order Reference number: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: "2626432"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
