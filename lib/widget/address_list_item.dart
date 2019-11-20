import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';

class AddressListItem extends StatelessWidget {
  final Address address;

  const AddressListItem({Key key, @required this.address}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        address.residential,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        address.gps,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}