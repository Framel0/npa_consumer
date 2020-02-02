import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:npa_user/data/consumer_info.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widgets.dart';

class AddressSelectPage extends StatefulWidget {
  @override
  _AddressSelectPageState createState() => _AddressSelectPageState();
}

class _AddressSelectPageState extends State<AddressSelectPage> {
  User user;
  int userId;
  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    user = await readUserData();
    userId = user.id;
    BlocProvider.of<AddressBloc>(context).dispatch(FetchAddresses(id: userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Delivery Address"),
        ),
        body: BlocBuilder<AddressBloc, AddressState>(builder: (context, state) {
          if (state is AddressLoading) {
            return Center(child: LoadingIndicator());
          }

          if (state is AddressLoaded) {
            final address = state.addresses;
            return ListView(
              children: <Widget>[
                _buildAddressList(address),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  width: MediaQuery.of(context).size.width,
                  child: OutlineButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    ),
                    borderSide: BorderSide(color: colorSecondaryOrange, width: 2),
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    child: Text(
                      "Add new Address",
                      style: TextStyle(
                          color: colorPrimary,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, newAddressRoute)
                          .then((onValue) {
                        setState(() {
                          BlocProvider.of<AddressBloc>(context)
                              .dispatch(FetchAddresses(id: userId));
                        });
                      });
                    },
                  ),
                ),
              ],
            );
          }

          if (state is AddressError) {
            return Container(
              child: Text("Error"),
            );
          }
        }));
  }

  Widget _buildAddressListItem(int position, Address address) {
    return AddressSelectListItem(
      address: address,
    );
  }

  Widget _buildAddressList(List<Address> addresses) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: addresses.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildAddressListItem(index, addresses[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(thickness: 2.0);
      },
    );
  }
}
