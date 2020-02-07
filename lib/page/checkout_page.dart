import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:npa_user/data/consumer_info.dart';
import 'package:npa_user/model/consumer_product.dart';
import 'package:npa_user/model/delivery_method.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/model/payment_method.dart';
import 'package:npa_user/page/summary_page.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/values/color.dart';

class CheackoutPage extends StatefulWidget {
  final List<ConsumerProduct> products;
  final List<PaymentMethod> paymentMethods;
  final List<DeliveryMethod> deliveryMethods;

  const CheackoutPage(
      {Key key,
      @required this.products,
      @required this.paymentMethods,
      @required this.deliveryMethods})
      : super(key: key);
  @override
  _CheackoutPageState createState() => _CheackoutPageState();
}

class _CheackoutPageState extends State<CheackoutPage> {
  final TextStyle radioButtonTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: colorPrimary,
  );
  final TextStyle headerTextStyle = TextStyle(
      color: colorSecondaryOrange, fontSize: 21, fontWeight: FontWeight.bold);

  final double cardElevation = 4;

  static DeliveryMethod _selectedDeliveryMethod;

  PaymentMethod _selectedPaymentMethod;

  Address _address = Address();
  User _user = User();

  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String consumerId = "";

  double _subTotal = 0.0;
  double _deliveryPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _selectedDeliveryMethod = widget.deliveryMethods[0];
    _selectedPaymentMethod = widget.paymentMethods[0];
    _deliveryPrice = _selectedDeliveryMethod.price;
    _getTotal();
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
        title: Text("Delivery"),
      ),
      body: Builder(builder: (context) {
        return Container(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 10),
            children: <Widget>[
              buildDetails(context),
              SizedBox(
                height: 30,
              ),
              buildDeliveryMethod(),
              SizedBox(
                height: 30,
              ),
              buildPaymentMethod(),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Card(
                        elevation: cardElevation,
                        // color: colorPrimary100,
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
                                        TextSpan(text: "$_subTotal"),
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
                                        TextSpan(text: "$_deliveryPrice"),
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
                                                "${_subTotal + _deliveryPrice}"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2.0)),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 12.0,
                                  ),
                                  onPressed: () => {
                                    if (_address.id != null)
                                      {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SummaryPage(
                                                    deliveryMethod:
                                                        _selectedDeliveryMethod,
                                                    paymentMethod:
                                                        _selectedPaymentMethod,
                                                    deliveryAddress: _address,
                                                    products: widget.products,
                                                    subTotal: _subTotal,
                                                    deliveryPrice:
                                                        _deliveryPrice,
                                                  )),
                                        )
                                      }
                                    else
                                      {
                                        FlushbarHelper.createInformation(
                                            message: "Please Select Address")
                                          ..show(context)
                                      }
                                  },
                                  child: Text(
                                    "Proceed To Summary",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  _getTotal() {
    for (var product in widget.products) {
      _subTotal += (product.price * product.selectedQuantity);
    }
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

  onChangedDeliveryMethod(DeliveryMethod selectedDeliveryMethod) {
    setState(() {
      _selectedDeliveryMethod = selectedDeliveryMethod;
      _deliveryPrice = _selectedDeliveryMethod.price;
    });
  }

  Widget _buildRadioListDeliveryMethod() {
    List<Widget> widgets = List<Widget>();
    for (DeliveryMethod method in widget.deliveryMethods) {
      widgets.add(RadioListTile(
        value: method,
        groupValue: _selectedDeliveryMethod,
        title: Text(
          method.name,
          style: radioButtonTextStyle,
        ),
        onChanged: onChangedDeliveryMethod,
        selected: _selectedDeliveryMethod == method,
        activeColor: colorSecondaryOrange,
      ));
    }

    return Column(
      children: widgets,
    );
  }

  onChangedPaymentMethod(PaymentMethod selectedPaymentMethod) {
    setState(() {
      _selectedPaymentMethod = selectedPaymentMethod;
    });
  }

  Widget _buildRadioListPaymentMethod() {
    List<Widget> widgets = List<Widget>();
    for (PaymentMethod method in widget.paymentMethods) {
      widgets.add(RadioListTile(
        value: method,
        groupValue: _selectedPaymentMethod,
        title: Text(method.name, style: radioButtonTextStyle),
        onChanged: onChangedPaymentMethod,
        selected: _selectedPaymentMethod == method,
        activeColor: colorSecondaryOrange,
      ));
    }

    return Column(
      children: widgets,
    );
  }

  Widget buildPaymentMethod() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Select Payment Method",
            style: headerTextStyle,
          ),
        ),
        Card(
          elevation: cardElevation,
          // color: colorPrimary100,
          child: _buildRadioListPaymentMethod(),
        )
      ],
    ));
  }

  Widget buildDeliveryMethod() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Select Delivery Method",
              style: headerTextStyle,
            ),
          ),
          Card(
            elevation: cardElevation,
            // color: colorPrimary100,
            child: _buildRadioListDeliveryMethod(),
          )
        ],
      ),
    );
  }

  Widget buildDetails(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Text(
                  "Details",
                  style: headerTextStyle,
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: cardElevation,
              // color: colorPrimary100,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Name: \n${firstName} ${lastName}",
                      style: Theme.of(context).textTheme.title.copyWith(
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
                      style: Theme.of(context).textTheme.title.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: colorPrimary,
                          ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Address:",
                      style: Theme.of(context).textTheme.title.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: colorPrimary,
                          ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _address.residentialAddress == null
                                  ? ""
                                  : _address.residentialAddress,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: colorPrimary,
                              ),
                            ),
                            Text(
                              _address.ghanaPostGpsaddress == null
                                  ? ""
                                  : _address.ghanaPostGpsaddress,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: colorPrimary,
                              ),
                            ),
                          ],
                        ),
                        OutlineButton(
                          child: Text(
                            "select or add address",
                            style: TextStyle(color: colorSecondaryOrange),
                          ),
                          onPressed: () {
                            _navigatrAddressSelect(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Refill Type",
                      style: Theme.of(context).textTheme.title.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: colorPrimary,
                          ),
                    ),
                    _buildCylinders()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _navigatrAddressSelect(BuildContext context) async {
    var result = await Navigator.pushNamed(context, addressChangeRoute);
    print(" result from map: $result");
    if (result != null) {
      setState(() {
        _address = result;
      });
    }
  }

  Widget _divider() {
    return Divider(
      thickness: 2,
    );
  }
}
