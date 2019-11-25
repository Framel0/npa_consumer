import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/region/region.dart';

class RegionRepository {
  final RegionApiClient regionApiClient;
  List<Region> _regions = [];

  RegionRepository({@required this.regionApiClient});

  Future<void> getRegions() async {
    _regions = await regionApiClient.fetchRegions();
  }

  List<Region> get regions {
    return List.from(_regions);
  }

  List<DropdownMenuItem<Region>> getDropdownMenuItems(District district) {
    List<DropdownMenuItem<Region>> items = List();

    final regions = _regions.where((r) {
      return r.id == district.regionId;
    }).toList();

    for (Region region in regions) {
      items.add(DropdownMenuItem(
        value: region,
        child: Text(region.name),
      ));
    }

    return items;
  }

  Region getDistrictRegion(District district) {
    final region = _regions.firstWhere((r) {
      return r.id == district.regionId;
    });

    return region;
  }
}
