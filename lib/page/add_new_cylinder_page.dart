import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:npa_user/model/product.dart';
import 'package:npa_user/page/pages.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widgets.dart';

class AddNewCylinderPage extends StatefulWidget {
  @override
  _AddNewCylinderPageState createState() => _AddNewCylinderPageState();
}

class _AddNewCylinderPageState extends State<AddNewCylinderPage> {
  final TextStyle checkboxTextStyle = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w600, color: colorPrimary);

  final TextStyle quantityTextStyle =
      TextStyle(fontSize: 18.0, color: colorPrimary);

  final TextStyle headerTextStyle = TextStyle(
      color: colorSecondaryOrange, fontSize: 21, fontWeight: FontWeight.bold);

  List<Product> _products;
  List<Product> _selecteProducts = [];

  @override
  void initState() {
    super.initState();

    _getProducts();
  }

  _getProducts() {
    BlocProvider.of<ProductBloc>(context).dispatch(
      FetchProducts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Cylinder"),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductLoading) {
          return Center(child: LoadingIndicator());
        }
        if (state is ProductLoaded) {
          _products = state.products;
          return Container(
            child: ListView(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Cylinder Types",
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
                                builder: (context) => AddNewCylinderSummaryPage(
                                      products: _selecteProducts,
                                    )),
                          )
                        }
                      else
                        {
                          FlushbarHelper.createInformation(
                              message:
                                  "Please Select Cylinder Type and Quantity")
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
          );
        }
        if (state is ProductError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Something went wrong!',
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
                onPressed: _getProducts,
              )
            ],
          );
        }
      }),
    );
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
          activeColor: colorSecondaryOrange,
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
              style: TextStyle(fontSize: 35, color: colorSecondaryOrange),
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
                style: TextStyle(fontSize: 30, color: colorSecondaryOrange)),
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
