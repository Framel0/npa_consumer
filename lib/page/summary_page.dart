import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/page/home_page.dart';
import 'package:npa_user/values/color.dart';

class SummaryPage extends StatefulWidget {
  final Address deliveryAddress;
  final List<Product> products;
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
  final TextStyle headerTextStyle =
      TextStyle(color: colorPrimary, fontSize: 20, fontWeight: FontWeight.w600);

  final double cardElevation = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Summary"),
      ),
      body: ListView(
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
                                    TextSpan(text: "${widget.subTotal}"),
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
                                    TextSpan(text: "${widget.deliveryPrice}"),
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
                            "Address: ",
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(fontSize: 17),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.deliveryAddress.residential,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                widget.deliveryAddress.gps,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Phone Number: \n+233247894562 ",
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
              onPressed: () => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                )
              },
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
        ],
      ),
    );
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
}
