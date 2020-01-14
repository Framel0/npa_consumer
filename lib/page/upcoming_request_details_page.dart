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
    final consumerFirstName = widget.upcomingRequest.firstName ?? "";
    final consumerLastName = widget.upcomingRequest.lastName ?? "";
    final houseNumber = widget.upcomingRequest.houseNumber ?? "";
    final streetName = widget.upcomingRequest.streetName ?? "";
    final residentialAddress = widget.upcomingRequest.residentialAddress ?? "";
    final deliveryMethodId = widget.upcomingRequest.deliveryMethodId ?? 0;
    final deliveryMethodName = widget.upcomingRequest.deliveryMethod ?? "";
    final paymentMethodId = widget.upcomingRequest.paymentMethodId ?? 0;
    final paymentMethodName = widget.upcomingRequest.paymentMethod ?? "";
    final dispatchId = widget.upcomingRequest.dispatchId ?? "";
    final dispatchFirstName = widget.upcomingRequest.dispatchFirstName ?? "";
    final dispatchLastName = widget.upcomingRequest.dispatchLastName ?? "";
    final dispatchPhoneNumber =
        widget.upcomingRequest.dispatchPhoneNumber ?? "";
    final statusId = widget.upcomingRequest.statusId ?? 0;
    return Scaffold(
      appBar: AppBar(),
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

              // _showFloatingFlushbar(
              //   mContext: context,
              //   icon: Icons.done_outline,
              //   backgroundColor: Colors.green,
              //   title: "Success",
              //   message: "Delivery Confirmed",
              // )..show(context).then((result) {
              //     Navigator.of(context).pushNamedAndRemoveUntil(
              //         homeRoute, (Route<dynamic> route) => false);
              //   });
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
                    products: widget.upcomingRequest.products,
                    mContext: context),
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

  _showFloatingFlushbar({
    @required BuildContext mContext,
    @required Color backgroundColor,
    @required IconData icon,
    @required String title,
    @required String message,
  }) {
    Flushbar<bool>(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(10),
      borderRadius: 8,
      backgroundColor: backgroundColor,
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      // All of the previous Flushbars could be dismissed by swiping down
      // now we want to swipe to the sides
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      flushbarStyle: FlushbarStyle.FLOATING,
      title: title,
      message: message,
      duration: Duration(seconds: 3),
      icon: Icon(
        icon,
        size: 28,
        color: Colors.white,
      ),
    )..show(mContext);
  }

  _showSnackbar(
      {@required BuildContext mContext,
      @required Color backgroundColor,
      @required String text}) {
    final snackBar = SnackBar(
      content: Text(text,
          style: TextStyle(
            color: Colors.white,
          )),
      backgroundColor: backgroundColor,
      elevation: 10,
    );

    Scaffold.of(mContext).showSnackBar(snackBar);
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
