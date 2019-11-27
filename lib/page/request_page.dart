import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/bloc.dart';
import 'package:npa_user/bloc/request_refill/request_refill.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/page/checkout_page.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widget.dart';

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
  List<Product> _products;
  //   Product(id: 1, code: "", name: "3 Kg", price: 10, quantity: 0),
  //   Product(id: 2, code: "", name: "6 Kg", price: 20, quantity: 0),
  //   Product(id: 3, code: "", name: "14 Kg", price: 40, quantity: 0),
  // ];

  List<Product> _selecteProducts = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RequestRefillBloc>(context).dispatch(FetchApis());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request"),
      ),
      body: BlocListener<RequestRefillBloc, RequestRefillState>(
        listener: (context, state) {},
        child: BlocBuilder<RequestRefillBloc, RequestRefillState>(
            builder: (context, state) {
          if (state is RequestRefillApiLoading) {
            return Center(child: LoadingIndicator());
          }

          if (state is RequestRefillApiLoaded) {
            _products = state.products;
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
                      itemCount: _products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildField(_products[index]);
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
                          if (_selecteProducts.isNotEmpty)
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheackoutPage(
                                          products: _selecteProducts,
                                          paymentMethods: _paymentMethods,
                                          deliveryMethods: _deliveryMethods,
                                        )),
                              )
                            }
                          else
                            {_showSnackbar(context)}
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
          if (state is ProductError) {}
        }),
      ),
    );
  }

  _showSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Please Select Refill Type and Quantity',
          style: TextStyle(
            color: Colors.white,
          )),
      backgroundColor: Colors.redAccent,
      elevation: 10,
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  _onProductSelected(bool selected, Product product) {
    if (selected == true) {
      setState(() {
        _selecteProducts.add(product);
        final item = _selecteProducts.firstWhere((c) => c.id == product.id);
        item.quantity = 1;
        print(_selecteProducts);
      });
    } else {
      setState(() {
        final item = _selecteProducts.firstWhere((c) => c.id == product.id);
        item.quantity = 0;
        _selecteProducts.remove(product);
        print(_selecteProducts);
      });
    }
  }

  Widget _buildField(Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[_checkBox(product), _buildQuantity(product)],
      ),
    );
  }

  Widget _checkBox(Product product) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: _selecteProducts.contains(product),
          onChanged: (bool selected) {
            _onProductSelected(selected, product);
          },
          activeColor: colorPrimaryYellow,
        ),
        Text(product.name, style: checkboxTextStyle),
      ],
    );
  }

  Widget _buildQuantity(Product product) {
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
              if (_selecteProducts.isNotEmpty) {
                final item =
                    _selecteProducts.firstWhere((c) => c.id == product.id);

                if (_selecteProducts.contains(item)) {
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
            "${product.quantity}",
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
              if (_selecteProducts.isNotEmpty) {
                final item =
                    _selecteProducts.firstWhere((c) => c.id == product.id);
                if (_selecteProducts.contains(item)) {
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
