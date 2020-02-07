import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:npa_user/data/consumer_info.dart';
import 'package:npa_user/model/consumer_product.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/values/color.dart';

class SummaryPage extends StatefulWidget {
  final Address deliveryAddress;
  final List<ConsumerProduct> products;
  final DeliveryMethod deliveryMethod;
  final PaymentMethod paymentMethod;
  final double subTotal;
  final double deliveryPrice;

  const SummaryPage({
    Key key,
    @required this.deliveryAddress,
    @required this.products,
    @required this.deliveryMethod,
    @required this.paymentMethod,
    @required this.subTotal,
    @required this.deliveryPrice,
  }) : super(key: key);
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final TextStyle headerTextStyle = TextStyle(
      color: colorSecondaryOrange, fontSize: 21, fontWeight: FontWeight.bold);

  final double cardElevation = 4;

  User _user = User();

  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String consumerId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  getUser() {
    readUserData().then((value) {
      setState(() {
        _user = value;
        firstName = _user.firstName ?? "";
        lastName = _user.lastName ?? "";
        phoneNumber = _user.phoneNumber ?? "";
        consumerId = _user.consumerCode ?? "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Summary"),
      ),
      body: BlocListener<RefillRequestBloc, RefillRequestState>(
        listener: (context, state) {
          if (state is RequestRefillSuccess) {
            FlushbarHelper.createSuccess(
              title: "Success",
              message: "Refill Request Sent",
            )..show(context).then((result) {
                Navigator.pushNamedAndRemoveUntil(
                    context, homeRoute, (Route<dynamic> route) => false);
              });
          }
          if (state is RequestRefillError) {
            FlushbarHelper.createError(
              title: "Error",
              message: "Refill Request Not Sent, Try again",
            )..show(context);
          }
        },
        child: BlocBuilder<RefillRequestBloc, RefillRequestState>(
            builder: (context, state) {
          return ListView(
            padding: EdgeInsets.symmetric(vertical: 10),
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Order",
                        style: headerTextStyle,
                      ),
                    ),
                    Card(
                        elevation: cardElevation,
                        // shape: new RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        // ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Subtotal",
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: colorPrimary,
                                        ),
                                  ),
                                  RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: colorPrimary,
                                          ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'GHC ',
                                        ),
                                        TextSpan(text: "${widget.subTotal}"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Delivery",
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: colorPrimary,
                                        ),
                                  ),
                                  RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: colorPrimary,
                                          ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'GHC ',
                                        ),
                                        TextSpan(
                                            text: "${widget.deliveryPrice}"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Total",
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: colorPrimary,
                                        ),
                                  ),
                                  RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: colorPrimary,
                                          ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'GHC ',
                                        ),
                                        TextSpan(
                                            text:
                                                "${widget.subTotal + widget.deliveryPrice}"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Details",
                        style: headerTextStyle,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        elevation: cardElevation,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Name: \n${firstName} ${lastName}",
                                style:
                                    Theme.of(context).textTheme.title.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: colorPrimary,
                                        ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Phone Number: \n${phoneNumber}",
                                style:
                                    Theme.of(context).textTheme.title.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: colorPrimary,
                                        ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Address: ",
                                style:
                                    Theme.of(context).textTheme.title.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: colorPrimary,
                                        ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.deliveryAddress.residentialAddress,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: colorPrimary,
                                    ),
                                  ),
                                  Text(
                                    widget.deliveryAddress.ghanaPostGpsaddress,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: colorPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Refill Type",
                                style:
                                    Theme.of(context).textTheme.title.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: colorPrimary,
                                        ),
                              ),
                              _buildCylinders(),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Delivery Method",
                        style: headerTextStyle,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                          elevation: cardElevation,
                          child: ListTile(
                            title: Text(
                              widget.deliveryMethod.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: colorPrimary,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Payment Method",
                      style: headerTextStyle,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                        elevation: cardElevation,
                        child: ListTile(
                          title: Text(
                            widget.paymentMethod.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: colorPrimary,
                            ),
                          ),
                        )),
                  ),
                ],
              )),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 12.0,
                  ),
                  onPressed: () => {onConfirmButtonPressed()},
                  child: Text(
                    "Confirm",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              // Container(
              //   child: state is RequestRefillLoading
              //       ? CircularProgressIndicator()
              //       : null,
              // ),
            ],
          );
        }),
      ),
    );
  }

  List<RefillRequestProduct> get requestProducts {
    List<RefillRequestProduct> refillRequestProducts = [];

    for (var p in widget.products) {
      refillRequestProducts
          .add(RefillRequestProduct(productId: p.id, quantity: p.selectedQuantity));
    }

    return refillRequestProducts;
  }

  onConfirmButtonPressed() async {
    final user = await readUserData();
    RefillRequest request = RefillRequest();
    request.consumerId = user.id;
    request.consmerAddressId = widget.deliveryAddress.id;
    request.deliveryMethodId = widget.deliveryMethod.id;
    request.paymentMethodId = widget.paymentMethod.id;
    request.refillRequestProducts = requestProducts;

    BlocProvider.of<RefillRequestBloc>(context)
        .dispatch(PostRefillRequest(refillRequest: request));
  }

  Widget _buildCylinders() {
    List<Widget> widgets = List<Widget>();
    for (ConsumerProduct product in widget.products) {
      widgets.add(
        Text(
          "${product.name} x ${product.selectedQuantity}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: colorPrimary,
          ),
        ),
      );
    }

    return Column(
      children: widgets,
    );
  }
}
