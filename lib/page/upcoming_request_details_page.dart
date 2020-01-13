import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/model/request_product.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widgets.dart';

class UpcomingRequestDetailPage extends StatelessWidget {
  final UpcomingRequest upcomingRequest;

  const UpcomingRequestDetailPage({Key key, @required this.upcomingRequest})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final requestId = upcomingRequest.id ?? 0;
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
      body: BlocListener<RefillRequestBloc, RefillRequestState>(
        listener: (context, state) {
          if (state is ConfirmDeliverySuccess) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                homeRoute, (Route<dynamic> route) => false);
          }
        },
        child: BlocBuilder<RefillRequestBloc, RefillRequestState>(
            builder: (context, state) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            children: <Widget>[
              _buildItem(
                  title: "Name",
                  subtitle: "$consumerFirstName $consumerLastName"),
              _space(),
              _buildItem(
                  title: "Address",
                  subtitle: "$houseNumber, $streetName, $residentialAddress"),
              _space(),
              _buildItem(
                  title: "Delivery Method", subtitle: "$deliveryMethodName"),
              _space(),
              _buildItem(
                  title: "Payment Method", subtitle: "$paymentMethodName"),
              _space(),
              Text('Refill Type: ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: colorPrimary)),
              _buildProducts(
                  products: upcomingRequest.products, mContext: context),
              _space(),
              _buildBottom(
                  context: context,
                  requestId: requestId,
                  deliveryMethodId: deliveryMethodId,
                  statusId: statusId,
                  dispatchId: dispatchId,
                  dispatchFirstName: dispatchFirstName,
                  dispatchLastName: dispatchLastName,
                  dispatchPhoneNumber: dispatchPhoneNumber),
              _space(),
              Container(
                child:
                    state is ConfirmDeliveryLoading ? LoadingIndicator() : null,
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _space() {
    return SizedBox(
      height: 15,
    );
  }

  Widget _confirmDeliveryButton({
    @required BuildContext mContext,
    @required int requestId,
  }) {
    return Container(
      width: MediaQuery.of(mContext).size.width,
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
            side: BorderSide(color: Colors.white)),
        padding: EdgeInsets.symmetric(vertical: 14.0),
        child: Text(
          "Confrim Delivery",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          BlocProvider.of<RefillRequestBloc>(mContext).dispatch(ConfirmDelivery(
            refillRequestId: requestId,
          ));
        },
      ),
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
    @required int requestId,
    @required int deliveryMethodId,
    @required int statusId,
    @required String dispatchId,
    @required String dispatchFirstName,
    @required String dispatchLastName,
    @required String dispatchPhoneNumber,
  }) {
    if (statusId == 4) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildItem(
                title: "Dispatch to Deliver",
                subtitle:
                    "$dispatchId \n$dispatchFirstName $dispatchLastName \n$dispatchPhoneNumber"),
            _space(),
            _confirmDeliveryButton(requestId: requestId, mContext: context)
          ],
        ),
      );
    } else if (statusId == 5) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildItem(
              title: "Dispatch to Deliver",
              subtitle:
                  "$dispatchId \n$dispatchFirstName $dispatchLastName \n$dispatchPhoneNumber"),
          _space(),
          Text("Dispatch to Confirm Payment")
        ],
      );
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
