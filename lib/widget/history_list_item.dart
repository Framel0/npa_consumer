import 'package:flutter/material.dart';
import 'package:npa_user/model/history.dart';

class HistoryListItem extends StatelessWidget {
  final History history;
  HistoryListItem(this.history);
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
                    text: 'Book Date: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: history.date)
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
                TextSpan(text: history.refillType),
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
                TextSpan(text: history.deliveryMethod),
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
                TextSpan(text: history.paymentMethod),
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
                TextSpan(text: history.orderNumber),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
