import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/region/region.dart';

class RegionRepository {
  final RegionApiClient regionApiClient;
  List<Region> _regions = [
    Region(
      id: 1,
      code: "",
      name: "Oti",
    ),
    Region(
      id: 2,
      code: "",
      name: "Bono East",
    ),
    Region(
      id: 3,
      code: "",
      name: "Ahafo",
    ),
    Region(
      id: 4,
      code: "",
      name: "Bono",
    ),
    Region(
      id: 5,
      code: "",
      name: "North East",
    ),
    Region(
      id: 6,
      code: "",
      name: "Savannah",
    ),
    Region(
      id: 7,
      code: "",
      name: "Western North",
    ),
    Region(
      id: 8,
      code: "",
      name: "Western",
    ),
    Region(
      id: 9,
      code: "",
      name: "Volta",
    ),
    Region(
      id: 10,
      code: "",
      name: "Greater Accra",
    ),
    Region(
      id: 11,
      code: "",
      name: "Eastern",
    ),
    Region(
      id: 12,
      code: "",
      name: "Ashanti",
    ),
    Region(
      id: 13,
      code: "",
      name: "Central",
    ),
    Region(
      id: 14,
      code: "",
      name: "Northern",
    ),
    Region(
      id: 15,
      code: "",
      name: "Upper East",
    ),
    Region(
      id: 16,
      code: "",
      name: "Upper West",
    ),
  ];

  RegionRepository({this.regionApiClient});

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
