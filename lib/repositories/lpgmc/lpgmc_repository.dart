import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/lpgmc/lpgmc.dart';

class LpgmcRepository {
  final LpgmcApiClient lpgmcApiClient;
  List<Lpgmc> _lpgmcs = [];

  LpgmcRepository({@required this.lpgmcApiClient});

  Future<void> getLpgmcs() async {
    _lpgmcs = await lpgmcApiClient.fetchLpgmcs();
  }

  List<Lpgmc> get lpgmcs {
    return List.from(_lpgmcs);
  }

  List<DropdownMenuItem<Lpgmc>> getDropdownMenuItems() {
    List<DropdownMenuItem<Lpgmc>> items = List();

    for (Lpgmc lpgmc in _lpgmcs) {
      items.add(DropdownMenuItem(
        value: lpgmc,
        child: Text(lpgmc.name),
      ));
    }
    return items;
  }
}
