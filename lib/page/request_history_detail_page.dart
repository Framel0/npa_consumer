import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    final date = requestHistory.date ?? null;
    final consumerCode = requestHistory.consumerCode ?? "";
    final consumerFirstName = requestHistory.firstName ?? "";
    final consumerLastName = requestHistory.lastName ?? "";
    final houseNumber = requestHistory.houseNumber ?? "";
    final streetName = requestHistory.streetName ?? "";
    final residentialAddress = requestHistory.residentialAddress ?? "";
    final deliveryMethodId = requestHistory.deliveryMethodId ?? 0;
    final deliveryMethodName = requestHistory.deliveryMethod ?? "";
    final paymentMethodId = requestHistory.paymentMethodId ?? 0;
    final paymentMethodName = requestHistory.paymentMethod ?? "";
    final dispatchCode = requestHistory.dispatchCode ?? "";
    final dispatchFirstName = requestHistory.dispatchFirstName ?? "";
    final dispatchLastName = requestHistory.dispatchLastName ?? "";
    final dispatchPhoneNumber = requestHistory.dispatchPhoneNumber ?? "";
    final statusId = requestHistory.statusId ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "History Details",
        ),
      ),
      body: Builder(builder: (context) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          children: <Widget>[
            _buildDate(
              text: DateFormat.yMMMMEEEEd('en_US').add_jm().format(date),
            ),
            _space10(),
            _buildHeading(
              text: "Consumer",
            ),
            _buildItem(
              ctx: context,
              title: "Consumer Code",
              subtitle: "$consumerCode",
            ),
            _space10(),
            _buildItem(
              ctx: context,
              title: "Name",
              subtitle: "$consumerFirstName $consumerLastName",
            ),
            _space10(),
            _buildItem(
              ctx: context,
              title: "Address",
              subtitle: "$houseNumber, $streetName, $residentialAddress",
            ),
            _space10(),
            _buildItem(
              ctx: context,
              title: "Delivery Method",
              subtitle: "$deliveryMethodName",
            ),
            _space10(),
            _buildItem(
              ctx: context,
              title: "Payment Method",
              subtitle: "$paymentMethodName",
            ),
            _space10(),
            Row(
              children: <Widget>[
                Text('Refill Type: ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: colorPrimary,
                    )),
                _buildProducts(
                  products: requestHistory.products,
                  mContext: context,
                ),
              ],
            ),
            _space15(),
            _buildHeading(
              text: "Dispatch",
            ),
            _space10(),
            _buildItem(
              ctx: context,
              title: "Dispatch Code",
              subtitle: "$dispatchCode",
            ),
            _space10(),
            _buildItem(
              ctx: context,
              title: "Name",
              subtitle: "$dispatchFirstName $dispatchLastName",
            ),
            _space10(),
            _buildItem(
              ctx: context,
              title: "Phone Number",
              subtitle: "$dispatchPhoneNumber",
            ),
            _space10(),
          ],
        );
      }),
    );
  }

  Widget _space10() {
    return SizedBox(
      height: 10,
    );
  }

  Widget _space15() {
    return SizedBox(
      height: 15,
    );
  }

  Widget _buildProducts(
      {List<RequestProduct> products, BuildContext mContext}) {
    List<Widget> widgets = List<Widget>();
    for (RequestProduct product in products) {
      widgets.add(
        Text("${product.size} x ${product.quantity}, ",
            style: TextStyle(
              fontSize: 16,
              color: colorPrimary,
            )),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Text _buildDate({@required String text}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        color: colorSecondaryGreen,
      ),
    );
  }

  Text _buildHeading({@required String text}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: colorSecondaryOrange),
    );
  }

  Widget _buildItem({
    @required BuildContext ctx,
    @required String title,
    String subtitle,
  }) {
    return RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: DefaultTextStyle.of(ctx).style,
        children: <TextSpan>[
          TextSpan(
            text: '$title: ',
            style: TextStyle(
              fontSize: 18,
              color: colorPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "$subtitle",
            style: TextStyle(
              fontSize: 16,
              color: colorPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
