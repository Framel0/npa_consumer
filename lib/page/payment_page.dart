import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        children: <Widget>[
          Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("Select Payment Method",
                    style: Theme.of(context).textTheme.headline),
              ),
            ],
          )),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("Use a Voucher",
                      style: Theme.of(context).textTheme.headline),
                ),
                Card(
                  child: Column(
                    children: <Widget>[],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
