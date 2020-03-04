import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:npa_user/model/choice.dart';
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
  int requestId;
  Choice _selectedChoice = choices[0]; // The app's "state".

  void _select(
    Choice choice,
  ) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
      if (_selectedChoice.id == 1) {
        _showDialog();
      }
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "Cancel Request",
            // style: TextStyle(
            //   fontWeight: FontWeight.bold,
            // ),
          ),
          content: Text("Are you sure you want to cancel the request?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text(
                "Cancel",
                style: TextStyle(
                  color: colorSecondaryOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(
                  color: colorPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                BlocProvider.of<RefillRequestBloc>(context)
                    .dispatch(CancelRequest(
                  refillRequestId: requestId,
                ));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    requestId = widget.upcomingRequest.id ?? 0;
    final date = widget.upcomingRequest.date ?? null;
    final consumerCode = widget.upcomingRequest.consumerCode ?? "";
    final consumerFirstName = widget.upcomingRequest.firstName ?? "";
    final consumerLastName = widget.upcomingRequest.lastName ?? "";
    final houseNumber = widget.upcomingRequest.houseNumber ?? "";
    final streetName = widget.upcomingRequest.streetName ?? "";
    final residentialAddress = widget.upcomingRequest.residentialAddress ?? "";
    final deliveryMethodId = widget.upcomingRequest.deliveryMethodId ?? 0;
    final deliveryMethod = widget.upcomingRequest.deliveryMethod ?? "";
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
          "Request Details",
        ),
        actions: <Widget>[
          PopupMenuButton<Choice>(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
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
                title: "Error",
                message: "Delivery Confirmed failed, Please try again",
              )..show(context);
            }
            if (state is CancelRequestSuccess) {
              FlushbarHelper.createSuccess(
                title: "Success",
                message: "Request Canceled",
              )..show(context).then((result) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      homeRoute, (Route<dynamic> route) => false);
                });
            }
            if (state is CancelRequestError) {
              FlushbarHelper.createError(
                title: "Error",
                message: state.error,
              )..show(context);
            }
          },
          child: BlocBuilder<RefillRequestBloc, RefillRequestState>(
              builder: (context, state) {
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
                  subtitle: "$deliveryMethod",
                ),
                _space10(),
                _buildItem(
                  ctx: context,
                  title: "Payment Method",
                  subtitle: "$paymentMethod",
                ),
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
                Container(
                  child:
                      state is CancelRequestLoading ? LoadingIndicator() : null,
                ),
                _space10(),
                _buildBottom(
                    context: context,
                    state: state,
                    requestId: requestId,
                    deliveryMethodId: deliveryMethodId,
                    statusId: statusId,
                    dispatchCode: dispatchCode,
                    dispatchFirstName: dispatchFirstName,
                    dispatchLastName: dispatchLastName,
                    dispatchPhoneNumber: dispatchPhoneNumber),
                _space10(),
              ],
            );
          }),
        );
      }),
    );
  }

  _cancelOrder({
    @required statusId,
  }) {
    if (statusId <= 4) {
      return IconButton(icon: null, onPressed: null);
    } else {}
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

  Widget _buildProducts(
      {List<RequestProduct> products, BuildContext mContext}) {
    List<Widget> widgets = List<Widget>();
    for (RequestProduct product in products) {
      widgets.add(
        Text("${product.size} x ${product.quantity}",
            style: TextStyle(fontSize: 16, color: colorPrimary)),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
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

  _buildBottom({
    @required BuildContext context,
    @required RefillRequestState state,
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
            _space15(),
            Container(
              child:
                  state is ConfirmDeliveryLoading ? LoadingIndicator() : null,
            ),
            _space10(),
            _confirmDeliveryButton(
              requestId: requestId,
              mContext: context,
            )
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
          _buildItem(
              ctx: context, title: "Dispatch Code", subtitle: "$dispatchCode"),
          _space10(),
          _buildItem(
              ctx: context,
              title: "Name",
              subtitle: "$dispatchFirstName $dispatchLastName"),
          _space10(),
          _buildItem(
              ctx: context,
              title: "Phone Number",
              subtitle: "$dispatchPhoneNumber"),
          _space15(),
          Text(
            "Dispatch to Confirm Payment",
            style: TextStyle(
              fontSize: 18,
              color: colorSecondaryGreen,
            ),
          )
        ],
      );
    } else {
      return Container();
    }
  }
}

const List<Choice> choices = const <Choice>[
  const Choice(id: 1, title: 'Cancel Request', icon: Icons.cancel),
];
