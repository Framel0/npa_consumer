import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/values/color.dart';

class Payment extends StatefulWidget {
  PaymentMethod selectedPaymentMethod;

  Payment({Key key, this.selectedPaymentMethod}) : super(key: key);
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  List<PaymentMethod> paymentMethods;

  @override
  void initState() {
    super.initState();
    // paymentMethods = PaymentMethod.getPaymentMethods();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("Select Payment Method",
              style: Theme.of(context).textTheme.headline),
        ),
        Card(
          elevation: 4,
          shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
          child: Column(children: _buildRadioListPaymentMethod()),
        )
      ],
    ));
  }

  onChangedPaymentMethod(PaymentMethod method) {
    setState(() {
      widget.selectedPaymentMethod = method;
    });
  }

  List<Widget> _buildRadioListPaymentMethod() {
    List<Widget> widgets = [];
    for (PaymentMethod method in paymentMethods) {
      widgets.add(RadioListTile(
        value: method,
        groupValue: widget.selectedPaymentMethod,
        title: Text(method.name),
        onChanged: onChangedPaymentMethod,
        selected: widget.selectedPaymentMethod == method,
        activeColor: colorSecondaryOrange,
      ));
    }

    return widgets;
  }
}
