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
  final TextStyle checkboxTextStyle = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w600, color: colorPrimary);
  final TextStyle quantityTextStyle =
      TextStyle(fontSize: 18.0, color: colorPrimary);
  final TextStyle headerTextStyle = TextStyle(
      color: colorSecondaryOrange, fontSize: 21, fontWeight: FontWeight.bold);

  List<PaymentMethod> _paymentMethods;
  List<DeliveryMethod> _deliveryMethods;
  List<ConsumerProduct> _consumerProducts;

  List<ConsumerProduct> _selectedConsumerProducts = [];

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
          return buildContainer(context);
        }
        if (state is RequestRefillApiError) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Something went wrong"),
                IconButton(
                  icon: Icon(
                    Icons.replay,
                    color: colorSecondaryOrange,
                  ),
                  onPressed: getRequests,
                )
              ],
            ),
          );
        }
      }),
      // ),
    );
  }

  Widget buildContainer(BuildContext context) {
    return _consumerProducts.isEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "No Products Available",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorPrimary,
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.replay,
                    color: colorSecondaryOrange,
                  ),
                  onPressed: getRequests)
            ],
          )
        : Container(
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
                      if (_selectedConsumerProducts.isNotEmpty)
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheackoutPage(
                                      products: _selectedConsumerProducts,
                                      paymentMethods: _paymentMethods,
                                      deliveryMethods: _deliveryMethods,
                                    )),
                          )
                        }
                      else
                        {
                          FlushbarHelper.createInformation(
                              message: "Please Select Refill Type and Quantity")
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
          );
  }

  _onConsumerProductSelected(bool selected, ConsumerProduct consumerProduct) {
    if (selected == true) {
      setState(() {
        _selectedConsumerProducts.add(consumerProduct);
        final item = _selectedConsumerProducts
            .firstWhere((c) => c.id == consumerProduct.id);
        item.selectedQuantity = 1;
        print(_selectedConsumerProducts);
      });
    } else {
      setState(() {
        final item = _selectedConsumerProducts
            .firstWhere((c) => c.id == consumerProduct.id);
        item.selectedQuantity = 0;
        _selectedConsumerProducts.remove(consumerProduct);
        print(_selectedConsumerProducts);
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
          value: _selectedConsumerProducts.contains(consumerProduct),
          onChanged: (bool selected) {
            _onConsumerProductSelected(selected, consumerProduct);
          },
          activeColor: colorSecondaryOrange,
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
              style: TextStyle(fontSize: 35, color: colorSecondaryOrange),
            ),
            onPressed: () {
              if (_selectedConsumerProducts.isNotEmpty) {
                final item = _selectedConsumerProducts
                    .firstWhere((c) => c.id == consumerProduct.id);

                if (_selectedConsumerProducts.contains(item)) {
                  if (item.selectedQuantity != 1) {
                    setState(() {
                      item.selectedQuantity -= 1;
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
            "${consumerProduct.selectedQuantity}",
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
                style: TextStyle(fontSize: 30, color: colorSecondaryOrange)),
            onPressed: () {
              if (_selectedConsumerProducts.isNotEmpty) {
                final item = _selectedConsumerProducts
                    .firstWhere((c) => c.id == consumerProduct.id);
                if (_selectedConsumerProducts.contains(item)) {
                  if (item.selectedQuantity < item.quantity) {
                    setState(() {
                      item.selectedQuantity += 1;
                    });
                  }
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
