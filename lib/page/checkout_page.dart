import 'package:flutter/material.dart';
import 'package:npa_user/model/delivery_method.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/model/payment_method.dart';
import 'package:npa_user/page/summary_page.dart';
import 'package:npa_user/repositories/repositories.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/values/color.dart';

class CheackoutPage extends StatefulWidget {
  final List<Product> products;
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
  final TextStyle radioButtonTextStyle = TextStyle(color: Colors.black);
  final TextStyle headerTextStyle =
      TextStyle(color: colorPrimary, fontSize: 20, fontWeight: FontWeight.w600);

  final double cardElevation = 3;

  static DeliveryMethod _selectedDeliveryMethod;

  PaymentMethod _selectedPaymentMethod;

  Address _address = Address();

  double _subTotal = 0.0;
  double _deliveryPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _selectedDeliveryMethod = widget.deliveryMethods[0];
    _selectedPaymentMethod = widget.paymentMethods[0];
    _deliveryPrice = _selectedDeliveryMethod.price;
    _getTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery"),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 10),
          children: <Widget>[
            Container(
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Name: \nJohn Doe",
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(fontSize: 17),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Address:",
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(fontSize: 17),
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
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      _address.ghanaPostGpsaddress == null
                                          ? ""
                                          : _address.ghanaPostGpsaddress,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                OutlineButton(
                                  child: Text(
                                    "select address",
                                    style: TextStyle(color: colorPrimaryYellow),
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
                              "Phone Number: \n+233247894562",
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(fontSize: 17),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Refill Type",
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(fontSize: 17),
                            ),
                            _buildCylinders()
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
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
                      child: _buildRadioListDeliveryMethod())
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
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
                    child: _buildRadioListPaymentMethod())
              ],
            )),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Column(
                children: <Widget>[
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Subtotal",
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(fontSize: 17),
                                ),
                                RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(fontSize: 17),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Delivery",
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(fontSize: 17),
                                ),
                                RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(fontSize: 17),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Total",
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(fontSize: 17),
                                ),
                                RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(fontSize: 17),
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
                                  if (_address != null)
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
                                                  deliveryPrice: _deliveryPrice,
                                                )),
                                      )
                                    }
                                  else
                                    {_showSnackbar(context)}
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
      ),
    );
  }

  _showSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Please Select Address',
          style: TextStyle(
            color: Colors.white,
          )),
      backgroundColor: Colors.redAccent,
      elevation: 10,
    );

    Scaffold.of(context).showSnackBar(snackBar);
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

  _getTotal() {
    for (var product in widget.products) {
      _subTotal += (product.price * product.quantity);
    }
  }

  Widget _buildCylinders() {
    List<Widget> widgets = List<Widget>();
    for (Product product in widget.products) {
      widgets.add(
        Text(
          "${product.name} x ${product.quantity}",
          style: TextStyle(fontSize: 16),
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
        activeColor: colorAccentYellow,
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
        activeColor: colorAccentYellow,
      ));
    }

    return Column(
      children: widgets,
    );
  }
}
