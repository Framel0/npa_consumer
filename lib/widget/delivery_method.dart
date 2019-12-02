import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/values/color.dart';

class Delivery extends StatefulWidget {
  DeliveryMethod selectedDeliveryMethod;

  Delivery({Key key, this.selectedDeliveryMethod}) : super(key: key);

  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  List<DeliveryMethod> deliveryMethods;

  @override
  void initState() {
    super.initState();
    // deliveryMethods = DeliveryMethod.getDeliveryMethods();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Select Delivery Method",
                style: Theme.of(context).textTheme.headline),
          ),
          Card(
            elevation: 4,
            shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            child: Column(children: _buildRadioListDeliveryMethod()),
          )
        ],
      ),
    );
  }

  onChangedDeliveryMethod(DeliveryMethod method) {
    setState(() {
      widget.selectedDeliveryMethod = method;
    });
  }

  List<Widget> _buildRadioListDeliveryMethod() {
    List<Widget> widgets = [];
    for (DeliveryMethod method in deliveryMethods) {
      widgets.add(RadioListTile(
        value: method,
        groupValue: widget.selectedDeliveryMethod,
        title: Text(method.name),
        onChanged: onChangedDeliveryMethod,
        selected: widget.selectedDeliveryMethod == method,
        activeColor: colorAccentYellow,
      ));
    }

    return widgets;
  }
}
