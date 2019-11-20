import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/repositories.dart';

class CylinderRepository {
  final CylinderApiClient cylinderApiClient;

  CylinderRepository({@required this.cylinderApiClient});

  List<Cylinder> _cylinders = [];

  Future getCylinders() async {}

  List<Lpgmc> get cylinders {
    return List.from(_cylinders);
  }

  List<DropdownMenuItem<Cylinder>> getDropdownMenuItems() {
    List<DropdownMenuItem<Cylinder>> items = List();

    for (Cylinder cylinder in _cylinders) {
      items.add(DropdownMenuItem(
        value: cylinder,
        child: Text(cylinder.name),
      ));
    }
    return items;
  }
}
