import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/bloc.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/page/checkout_page.dart';
import 'package:npa_user/values/color.dart';

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

  List<Cylinder> _cylinders = [
    Cylinder(id: 1, code: "", name: "3 Kg", price: 10, quantity: 0),
    Cylinder(id: 2, code: "", name: "6 Kg", price: 20, quantity: 0),
    Cylinder(id: 3, code: "", name: "14 Kg", price: 40, quantity: 0),
  ];

  List<Cylinder> _selecteCylinders = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request"),
      ),
      body: BlocBuilder<CounterBloc, int>(builder: (context, count) {
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
                  itemCount: _cylinders.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildField(_cylinders[index]);
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
                      if (_selecteCylinders.isNotEmpty)
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheackoutPage(
                                      cylinders: _selecteCylinders,
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
      }),
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

  _onCylinderSelected(bool selected, Cylinder cylinder) {
    if (selected == true) {
      setState(() {
        _selecteCylinders.add(cylinder);
        final item = _selecteCylinders.firstWhere((c) => c.id == cylinder.id);
        item.quantity = 1;
        print(_selecteCylinders);
      });
    } else {
      setState(() {
        final item = _selecteCylinders.firstWhere((c) => c.id == cylinder.id);
        item.quantity = 0;
        _selecteCylinders.remove(cylinder);
        print(_selecteCylinders);
      });
    }
  }

  Widget _buildField(Cylinder cylinder) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[_checkBox(cylinder), _buildQuantity(cylinder)],
      ),
    );
  }

  Widget _checkBox(Cylinder cylinder) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: _selecteCylinders.contains(cylinder),
          onChanged: (bool selected) {
            _onCylinderSelected(selected, cylinder);
          },
          activeColor: colorPrimaryYellow,
        ),
        Text(cylinder.name, style: checkboxTextStyle),
      ],
    );
  }

  Widget _buildQuantity(Cylinder cylinder) {
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
              if (_selecteCylinders.isNotEmpty) {
                final item =
                    _selecteCylinders.firstWhere((c) => c.id == cylinder.id);

                if (_selecteCylinders.contains(item)) {
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
            "${cylinder.quantity}",
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
              if (_selecteCylinders.isNotEmpty) {
                final item =
                    _selecteCylinders.firstWhere((c) => c.id == cylinder.id);
                if (_selecteCylinders.contains(item)) {
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
