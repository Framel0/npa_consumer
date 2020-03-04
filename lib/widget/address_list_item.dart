import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/values/color.dart';

class AddressListItem extends StatelessWidget {
  final Address address;

  const AddressListItem({Key key, @required this.address}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        address.residentialAddress,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colorPrimary,
        ),
      ),
      subtitle: Text(
        address.ghanaPostGpsAddress,
        style: TextStyle(
          fontSize: 14,
          color: colorPrimary,
        ),
      ),
    );
  }
}
