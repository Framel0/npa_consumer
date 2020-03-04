import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/bloc/consumer_product/consumer_product.dart';
import 'package:npa_user/data/consumer_info.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widgets.dart';

class AddNewCylinderSummaryPage extends StatefulWidget {
  final List<Product> products;
  final List<Deposite> deposits;

  const AddNewCylinderSummaryPage({
    Key key,
    @required this.products,
    @required this.deposits,
  }) : super(key: key);
  @override
  _AddNewCylinderSummaryPageState createState() =>
      _AddNewCylinderSummaryPageState();
}

class _AddNewCylinderSummaryPageState extends State<AddNewCylinderSummaryPage> {
  final TextStyle headerTextStyle = TextStyle(
      color: colorSecondaryOrange, fontSize: 20, fontWeight: FontWeight.bold);

  final TextStyle radioButtonTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: colorPrimary,
  );

  double _subTotal = 0.0;

  Deposite _selectedDeposite;

  User user = User();

  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  @override
  void initState() {
    super.initState();
    _selectedDeposite = widget.deposits[0];
    _getTotal();
    _getUser();
  }

  _getTotal() {
    for (var product in widget.products) {
      _subTotal += (product.price * product.quantity);
    }
  }

  _getUser() {
    readUserData().then((value) {
      setState(() {
        user = value;
        firstName = user.firstName ?? "";
        lastName = user.lastName ?? "";
        phoneNumber = user.phoneNumber ?? "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Summary"),
      ),
      body: BlocListener<ConsumerProductBloc, ConsumerProductState>(
        listener: (context, state) {
          if (state is AddNewConsumerProductSuccess) {
            FlushbarHelper.createSuccess(
              title: "Success",
              message: "Request Sent",
            )..show(context).then((result) {
                Navigator.pushNamedAndRemoveUntil(
                    context, homeRoute, (Route<dynamic> route) => false);
              });
          }
          if (state is AddNewConsumerProductError) {
            FlushbarHelper.createError(
              title: "Error",
              message: "Request Not Sent, Try again",
            )..show(context);
          }
        },
        child: BlocBuilder<ConsumerProductBloc, ConsumerProductState>(
            builder: (context, state) {
          return ListView(
            padding: EdgeInsets.symmetric(vertical: 10),
            children: <Widget>[
              _buildDeposite(),
              _buildSizedBox(),
              // Container(
              //   child: _selectedDeposite.id == 1
              //       ? Column(
              //           children: <Widget>[
              //             _buildOrder(context),
              //             _buildSizedBox(),
              //           ],
              //         )
              //       : null,
              // ),
              _buildOrder(context),
              _buildSizedBox(),
              _buildDetails(context),
              _buildSizedBox(),
              _buildProducts(context),
              _buildSizedBox(),
              Container(
                child: state is AddNewConsumerProductLoading
                    ? LoadingIndicator()
                    : null,
              ),
              _buildConfirmButton(context),
            ],
          );
        }),
      ),
    );
  }

  SizedBox _buildSizedBox() {
    return SizedBox(
      height: 20,
    );
  }

  List<AddNewCylinderRequestProduct> get requestProducts {
    List<AddNewCylinderRequestProduct> stockRequestProducts = [];

    for (var p in widget.products) {
      stockRequestProducts.add(
          AddNewCylinderRequestProduct(productId: p.id, quantity: p.quantity));
    }

    return stockRequestProducts;
  }

  onConfirmButtonPressed() async {
    final user = await readUserData();
    AddNewCylinderRequest request = AddNewCylinderRequest();
    request.consumerId = user.id;
    request.depositId = _selectedDeposite.id;
    request.addNewCylinderRequestProduct = requestProducts;

    BlocProvider.of<ConsumerProductBloc>(context)
        .dispatch(AddNewConsumerProducts(addNewCylinderRequest: request));
  }

  Container _buildConfirmButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        onPressed: () => {onConfirmButtonPressed()},
        child: Text(
          "Confirm",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  Container _buildProducts(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Products",
              style: headerTextStyle,
            ),
          ),
          Card(
            elevation: 4,
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.products.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    "${widget.products[index].name} x ${widget.products[index].quantity.toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: colorPrimary,
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 1,
                  thickness: 1.5,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  onChangedDeposite(Deposite selectedDeposite) {
    setState(() {
      _selectedDeposite = selectedDeposite;
      if (_selectedDeposite.id == 2) {
        _subTotal = 0.0;
      } else {
        _getTotal();
      }
    });
  }

  Widget _buildRadioListDeposite() {
    List<Widget> widgets = List<Widget>();
    for (Deposite method in widget.deposits) {
      widgets.add(RadioListTile(
        value: method,
        groupValue: _selectedDeposite,
        title: Text(method.name, style: radioButtonTextStyle),
        onChanged: onChangedDeposite,
        selected: _selectedDeposite == method,
        activeColor: colorSecondaryOrange,
      ));
    }

    return Column(
      children: widgets,
    );
  }

  Widget _buildDeposite() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Select Deposit",
            style: headerTextStyle,
          ),
        ),
        Card(
          elevation: 4,
          // color: colorPrimary100,
          child: _buildRadioListDeposite(),
        )
      ],
    ));
  }

  Container _buildDetails(BuildContext context) {
    return Container(
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
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Name: \n$firstName $lastName",
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
                      "Phone Number: \n$phoneNumber",
                      style: Theme.of(context).textTheme.title.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: colorPrimary,
                          ),
                    ),
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
    );
  }

  Container _buildOrder(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Amount",
              style: headerTextStyle,
            ),
          ),
          Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Total",
                          style: Theme.of(context).textTheme.title.copyWith(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: colorPrimary,
                              ),
                        ),
                        RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: Theme.of(context).textTheme.title
                              ..copyWith(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: colorPrimary,
                              ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'GHC ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: colorPrimary,
                                  )),
                              TextSpan(
                                  text: "$_subTotal",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: colorPrimary,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
