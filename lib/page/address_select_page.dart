import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/repositories.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widgets.dart';

class AddressSelectPage extends StatelessWidget {
  AddressRepository addressRepository = AddressRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Delivery Address"),
        ),
        body: ListView(
          children: <Widget>[
            _buildAddressList(addressRepository.addresses),
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
                borderSide: BorderSide(color: colorAccentYellow, width: 2),
                padding: EdgeInsets.symmetric(vertical: 14.0),
                child: Text(
                  "Add new Address",
                  style: TextStyle(
                      color: colorPrimary,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, newAddressRoute);
                },
              ),
            ),
          ],
        ));
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
