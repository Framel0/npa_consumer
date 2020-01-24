import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:npa_user/data/consumer_info.dart';
import 'package:npa_user/model/consumer_product.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/page/checkout_page.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widgets.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final TextStyle checkboxTextStyle =
      TextStyle(fontSize: 18.0, color: colorPrimary);
  final TextStyle quantityTextStyle = TextStyle(
    fontSize: 18.0,
  );
  final TextStyle headerTextStyle =
      TextStyle(color: colorPrimary, fontSize: 20, fontWeight: FontWeight.w600);

  List<PaymentMethod> _paymentMethods;
  List<DeliveryMethod> _deliveryMethods;
  List<ConsumerProduct> _consumerProducts;

  List<ConsumerProduct> _selecteConsumerProducts = [];

  @override
  void initState() {
    super.initState();

    getRequests();
  }

  getRequests() async {
    final user = await readUserData();

    BlocProvider.of<RefillRequestBloc>(context)
        .dispatch(FetchApis(userId: user.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request"),
      ),
      body:
          // BlocListener<RequestRefillBloc, RequestRefillState>(
          //   listener: (context, state) {
          //     if (state is RequestRefillError) {
          //       Scaffold.of(context).showSnackBar(
          //         SnackBar(
          //           content: Text('${state.error}'),
          //           backgroundColor: Colors.red,
          //         ),
          //       );
          //     }
          //   },
          //   child:
          BlocBuilder<RefillRequestBloc, RefillRequestState>(
              builder: (context, state) {
        if (state is RequestRefillApiLoading) {
          return Center(child: LoadingIndicator());
        }

        if (state is RequestRefillApiLoaded) {
          _consumerProducts = state.consumerProducts;
          _paymentMethods = state.paymentMethods;
          _deliveryMethods = state.deliveryMethods;
          return SafeArea(
            child: Container(
              child: ListView(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Refill Type",
                      style: headerTextStyle,
                    ),
                  ),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _consumerProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildField(_consumerProducts[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        thickness: 2,
                      );
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: RaisedButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 12.0,
                      ),
                      onPressed: () => {
                        if (_selecteConsumerProducts.isNotEmpty)
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheackoutPage(
                                        products: _selecteConsumerProducts,
                                        paymentMethods: _paymentMethods,
                                        deliveryMethods: _deliveryMethods,
                                      )),
                            )
                          }
                        else
                          {
                            FlushbarHelper.createInformation(
                                message:
                                    "Please Select Refill Type and Quantity")
                              ..show(context)
                          }
                      },
                      child: Text(
                        "Proceed To Payment",
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
            ),
          );
        }
        if (state is RequestRefillApiError) {
          return Center(
            child: Text("Something went wrong"),
          );
        }
      }),
      // ),
    );
  }

  _onConsumerProductSelected(bool selected, ConsumerProduct consumerProduct) {
    if (selected == true) {
      setState(() {
        _selecteConsumerProducts.add(consumerProduct);
        final item = _selecteConsumerProducts
            .firstWhere((c) => c.id == consumerProduct.id);
        item.quantity = 1;
        print(_selecteConsumerProducts);
      });
    } else {
      setState(() {
        final item = _selecteConsumerProducts
            .firstWhere((c) => c.id == consumerProduct.id);
        item.quantity = 0;
        _selecteConsumerProducts.remove(consumerProduct);
        print(_selecteConsumerProducts);
      });
    }
  }

  Widget _buildField(ConsumerProduct consumerProduct) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _checkBox(consumerProduct),
          _buildQuantity(consumerProduct)
        ],
      ),
    );
  }

  Widget _checkBox(ConsumerProduct consumerProduct) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: _selecteConsumerProducts.contains(consumerProduct),
          onChanged: (bool selected) {
            _onConsumerProductSelected(selected, consumerProduct);
          },
          activeColor: colorPrimaryYellow,
        ),
        Text(consumerProduct.name, style: checkboxTextStyle),
      ],
    );
  }

  Widget _buildQuantity(ConsumerProduct consumerProduct) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 50,
          child: FlatButton(
            shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
            ),
            child: Text(
              "-",
              style: TextStyle(fontSize: 35, color: colorPrimaryYellow),
            ),
            onPressed: () {
              if (_selecteConsumerProducts.isNotEmpty) {
                final item = _selecteConsumerProducts
                    .firstWhere((c) => c.id == consumerProduct.id);

                if (_selecteConsumerProducts.contains(item)) {
                  if (item.quantity != 1) {
                    setState(() {
                      item.quantity -= 1;
                    });
                  }
                }
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "${consumerProduct.quantity}",
            style: quantityTextStyle,
          ),
        ),
        Container(
          width: 50,
          child: FlatButton(
            shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
            ),
            child: Text("+",
                style: TextStyle(fontSize: 30, color: colorPrimaryYellow)),
            onPressed: () {
              if (_selecteConsumerProducts.isNotEmpty) {
                final item = _selecteConsumerProducts
                    .firstWhere((c) => c.id == consumerProduct.id);
                if (_selecteConsumerProducts.contains(item)) {
                  setState(() {
                    item.quantity += 1;
                  });
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
