import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:npa_user/model/request_history.dart';
import 'package:npa_user/model/request_product.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/values/color.dart';

class RequestHistoryListItem extends StatelessWidget {
  final RequestHistory history;
  RequestHistoryListItem(this.history);
  @override
  Widget build(BuildContext context) {
    final date = history.date ?? null;
    final firstName = history.firstName ?? "";
    final lastName = history.lastName ?? "";
    final deliveryMethod = history.deliveryMethod ?? "";
    final paymentMethod = history.paymentMethod ?? "";
    final status = history.status ?? "";
    return ListTile(
        onTap: () {
          Navigator.pushNamed(context, requestHistoryDetailRoute,
              arguments: history);
        },
        subtitle: _buildSubtitle(
          ctx: context,
          date: DateFormat.yMMMEd('en_US').add_jm().format(date),
          consumerName: "$firstName $lastName",
          deliveryMethod: deliveryMethod,
          paymentMethod: paymentMethod,
        ));
  }

  Widget _buildProducts(
      {List<RequestProduct> products, BuildContext mContext}) {
    List<Widget> widgets = List<Widget>();
    for (RequestProduct product in products) {
      widgets.add(
        Text("${product.size} x ${product.quantity}"),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  _buildSubtitle({
    @required BuildContext ctx,
    @required String date,
    @required String consumerName,
    @required String deliveryMethod,
    @required String paymentMethod,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        sizedBox(),
        text(
          ctx: ctx,
          title: "Date",
          subtitle: date,
        ),
        sizedBox(),
        text(
          ctx: ctx,
          title: "Name",
          subtitle: consumerName,
        ),
        sizedBox(),
        text(
          ctx: ctx,
          title: "Delivery Method",
          subtitle: deliveryMethod,
        ),
        sizedBox(),
        text(
          ctx: ctx,
          title: "Payment Method",
          subtitle: paymentMethod,
        ),
        SizedBox(height: 8.0),
      ],
    );
  }

  Widget text({
    @required BuildContext ctx,
    @required String title,
    @required String subtitle,
  }) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: DefaultTextStyle.of(ctx).style,
        children: <TextSpan>[
          TextSpan(
            text: '$title: ',
            style: TextStyle(
              fontSize: 15,
              color: colorPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "$subtitle",
            style: TextStyle(
              fontSize: 14,
              color: colorPrimary,
            ),
          ),
        ],
      ),
    );
  }

  SizedBox sizedBox() => SizedBox(height: 4.0);
}
