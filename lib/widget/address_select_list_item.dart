import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';

class AddressSelectListItem extends StatelessWidget {
  final Address address;

  const AddressSelectListItem({Key key, @required this.address})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pop(context, address);
      },
      title: Text(
        address.residentialAddress,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        address.ghanaPostGpsAddress,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
