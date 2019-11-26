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

  const CheackoutPage({Key key, @required this.products}) : super(key: key);
  @override
  _CheackoutPageState createState() => _CheackoutPageState();
}

class _CheackoutPageState extends State<CheackoutPage> {
  final TextStyle radioButtonTextStyle = TextStyle(color: Colors.black);
  final TextStyle headerTextStyle =
      TextStyle(color: colorPrimary, fontSize: 20, fontWeight: FontWeight.w600);

  final double cardElevation = 3;

  List<DeliveryMethod> deliveryMethods;
  DeliveryMethod _selectedDeliveryMethod;

  List<PaymentMethod> paymentMethods;
  PaymentMethod _selectedPaymentMethod;

  AddressRepository addressRepository = AddressRepository();
  Address _address;

  double _subTotal = 0;
  double _deliveryPrice = 5;

  @override
  void initState() {
    super.initState();
    deliveryMethods = DeliveryMethod.getDeliveryMethods();
    _selectedDeliveryMethod = deliveryMethods[0];
    paymentMethods = PaymentMethod.getPaymentMethods();
    _selectedPaymentMethod = paymentMethods[0];
    _address = addressRepository.getAddresses[0];
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
                                      _address.residential,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      _address.gps,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                OutlineButton(
                                  child: Text(
                                    "change address",
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
    });

    if (_selectedDeliveryMethod.id == 1) {
      setState(() {
        _deliveryPrice = 5;
      });
    } else if (_selectedDeliveryMethod.id == 2) {
      setState(() {
        _deliveryPrice = 0;
      });
    }
  }

  Widget _buildRadioListDeliveryMethod() {
    List<Widget> widgets = List<Widget>();
    for (DeliveryMethod method in deliveryMethods) {
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
    for (PaymentMethod method in paymentMethods) {
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
