import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/district/district.dart';

class DistrictRepository {
  final DistrictApiClient districtApiClient;

  List<District> _districts = [];
  DistrictRepository({@required this.districtApiClient})
      : assert(districtApiClient != null);

  Future<void> getDistricts() async {
    _districts = await districtApiClient.fetchDistricts();
  }

  List<District> get districts {
    return List.from(_districts);
  }

  List<DropdownMenuItem<District>> getDropdownMenuItems() {
    List<DropdownMenuItem<District>> items = List();

    for (District district in _districts) {
      items.add(DropdownMenuItem(
        value: district,
        child: Text(district.name),
      ));
    }

    return items;
  }

  List<DropdownMenuItem<District>> getDropdownMenuItem() {
    List<DropdownMenuItem<District>> items = List();

    for (District district in _districts) {
      items.add(DropdownMenuItem(
        value: district,
        child: Text(district.name),
      ));
    }

    return items;
  }
}
