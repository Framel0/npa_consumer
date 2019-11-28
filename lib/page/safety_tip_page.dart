import 'package:flutter/material.dart';
import 'package:npa_user/model/safety_tip.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widgets.dart';

class SafetyTipPage extends StatefulWidget {
  @override
  _SafetyTipPageState createState() => _SafetyTipPageState();
}

class _SafetyTipPageState extends State<SafetyTipPage> {
  List<SafetyTip> st = [
    SafetyTip(name: "Safety Tip 1"),
    SafetyTip(name: "Safety Tip 2"),
    SafetyTip(name: "Safety Tip 3")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Safety Tips",
        ),
      ),
      body: _buildSafetyTipList(st),
    );
  }

  Widget _buildSafetyTipItems(
      BuildContext context, int position, SafetyTip safetyTip) {
    return SafetyTipListItem(st: safetyTip);
  }

  Widget _buildSafetyTipList(List<SafetyTip> safetyTips) {
    return ListView.separated(
      // padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      itemBuilder: (BuildContext context, int index) {
        return _buildSafetyTipItems(context, index, safetyTips[index]);
      },
      itemCount: safetyTips.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 4.0,
          thickness: 2.0,
          color: colorAccentYellow,
        );
      },
    );
  }
}
