import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/repositories.dart';
import 'package:npa_user/widget/widget.dart';

class AddressList extends StatefulWidget {
  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  AddressRepository addressRepository = AddressRepository();

  @override
  Widget build(BuildContext context) {
    return _buildAddressList(addressRepository.getAddresses);
  }

  Widget _buildAddressListItem(int position, Address address) {
    return AddressListItem(
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
