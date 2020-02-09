import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/model/request_product.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widgets.dart';

class UpcomingRequestDetailPage extends StatefulWidget {
  final UpcomingRequest upcomingRequest;

  const UpcomingRequestDetailPage({Key key, @required this.upcomingRequest})
      : super(key: key);

  @override
  _UpcomingRequestDetailPageState createState() =>
      _UpcomingRequestDetailPageState();
}

class _UpcomingRequestDetailPageState extends State<UpcomingRequestDetailPage> {
  Flushbar flush;
  bool _dismissed;
  @override
  Widget build(BuildContext context) {
    final requestId = widget.upcomingRequest.id ?? 0;
    final consumerCode = widget.upcomingRequest.consumerCode ?? "";
    final consumerFirstName = widget.upcomingRequest.firstName ?? "";
    final consumerLastName = widget.upcomingRequest.lastName ?? "";
    final houseNumber = widget.upcomingRequest.houseNumber ?? "";
    final streetName = widget.upcomingRequest.streetName ?? "";
    final residentialAddress = widget.upcomingRequest.residentialAddress ?? "";
    final deliveryMethodId = widget.upcomingRequest.deliveryMethodId ?? 0;
    final deliveryMethod = widget.upcomingRequest.deliveryMethod ?? "";
    final paymentMethodId = widget.upcomingRequest.paymentMethodId ?? 0;
    final paymentMethod = widget.upcomingRequest.paymentMethod ?? "";
    final dispatchCode = widget.upcomingRequest.dispatchCode ?? "";
    final dispatchFirstName = widget.upcomingRequest.dispatchFirstName ?? "";
    final dispatchLastName = widget.upcomingRequest.dispatchLastName ?? "";
    final dispatchPhoneNumber =
        widget.upcomingRequest.dispatchPhoneNumber ?? "";
    final statusId = widget.upcomingRequest.statusId ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Refill Request",
        ),
      ),
      body: Builder(builder: (context) {
        return BlocListener<RefillRequestBloc, RefillRequestState>(
          listener: (context, state) {
            if (state is ConfirmDeliverySuccess) {
              FlushbarHelper.createSuccess(
                title: "Success",
                message: "Delivery Confirmed",
              )..show(context).then((result) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      homeRoute, (Route<dynamic> route) => false);
                });
            }
            if (state is ConfirmDeliveryError) {
              FlushbarHelper.createError(
                title: "Success",
                message: "Delivery Confirmed",
              )..show(context);
            }
          },
          child: BlocBuilder<RefillRequestBloc, RefillRequestState>(
              builder: (context, state) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: <Widget>[
                _buildHeading(
                  text: "Consumer",
                ),
                _buildItem(title: "Consumer Code", subtitle: "$consumerCode"),
                _space10(),
                _buildItem(
                    title: "Name",
                    subtitle: "$consumerFirstName $consumerLastName"),
                _space10(),
                _buildItem(
                    title: "Address",
                    subtitle: "$houseNumber, $streetName, $residentialAddress"),
                _space10(),
                _buildItem(
                    title: "Delivery Method", subtitle: "$deliveryMethod"),
                _space10(),
                _buildItem(title: "Payment Method", subtitle: "$paymentMethod"),
                _space10(),
                Text('Refill Type',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: colorPrimary)),
                _buildProducts(
                    products: widget.upcomingRequest.products,
                    mContext: context),
                _space15(),
                _buildBottom(
                    context: context,
                    requestId: requestId,
                    deliveryMethodId: deliveryMethodId,
                    statusId: statusId,
                    dispatchCode: dispatchCode,
                    dispatchFirstName: dispatchFirstName,
                    dispatchLastName: dispatchLastName,
                    dispatchPhoneNumber: dispatchPhoneNumber),
                _space10(),
                Container(
                  child: state is ConfirmDeliveryLoading
                      ? LoadingIndicator()
                      : null,
                ),
              ],
            );
          }),
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
            style: TextStyle(fontSize: 16, color: colorPrimary)),
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
    @required String dispatchCode,
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
            _buildHeading(
              text: "Dispatch",
            ),
            _space10(),
            _buildItem(title: "Dispatch Code", subtitle: "$dispatchCode"),
            _space10(),
            _buildItem(
                title: "Name",
                subtitle: "$dispatchFirstName $dispatchLastName"),
            _space10(),
            _buildItem(title: "Phone Number", subtitle: "$dispatchPhoneNumber"),
            _space15(),
            _confirmDeliveryButton(requestId: requestId, mContext: context)
          ],
        ),
      );
    } else if (statusId == 5) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeading(
            text: "Dispatch",
          ),
          _space10(),
          _buildItem(title: "Dispatch Code", subtitle: "$dispatchCode"),
          _space10(),
          _buildItem(
              title: "Name", subtitle: "$dispatchFirstName $dispatchLastName"),
          _space10(),
          _buildItem(title: "Phone Number", subtitle: "$dispatchPhoneNumber"),
          _space15(),
          Text("Dispatch to Confirm Payment")
        ],
      );
    } else {
      return Container();
    }
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

  Widget _buildItem({@required String title, String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colorPrimary,
          ),
        ),
        Text(subtitle,
            style: TextStyle(
              fontSize: 16,
              color: colorPrimary,
            )),
      ],
    );
  }
}
