import 'package:flutter/material.dart';
import 'package:npa_user/model/safety_tip.dart';

class SafetyTipListItem extends StatelessWidget {
  final SafetyTip st;

  SafetyTipListItem({Key key, this.st}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(st.name),
      trailing: Icon(Icons.navigate_next),
    );
  }
}
