import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/repositories.dart';

class CylinderSizeRepository {
  final CylinderSizeApiClient cylinderSizeApiClient;

  CylinderSizeRepository({@required this.cylinderSizeApiClient});

  List<CylinderSize> _cylinderSizes = [];

  Future getCylinderSizes() async {
    _cylinderSizes = await cylinderSizeApiClient.fetchCylinderSizes();
  }

  List<Lpgmc> get cylinderSizes {
    return List.from(_cylinderSizes);
  }

  List<DropdownMenuItem<CylinderSize>> getDropdownMenuItems() {
    List<DropdownMenuItem<CylinderSize>> items = List();

    for (CylinderSize cylinderSize in _cylinderSizes) {
      items.add(DropdownMenuItem(
        value: cylinderSize,
        child: Text(cylinderSize.size),
      ));
    }
    return items;
  }
}
