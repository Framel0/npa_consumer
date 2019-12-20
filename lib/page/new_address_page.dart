import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:npa_user/data/consumer_info.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/widget/widgets.dart';

class NewAddressPage extends StatefulWidget {
  @override
  _NewAddressPageState createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  User user;
  int userId;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() {
    readUserData().then((value) {
      setState(() {
        user = value;
        userId = user.id;
      });
    });
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  BlocProvider.of<AddressBloc>(context)
                      .dispatch(FetchAddresses(id: userId));
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Address"),
      ),
      body: Container(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            children: <Widget>[
              NewAddressForm(),
            ],
          ),
        ),
      ),
    );
  }
}
