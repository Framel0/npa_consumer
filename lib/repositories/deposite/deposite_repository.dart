import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/deposite/deposite.dart';

class DepositeRepository {
  final DepositeApiClient depositeApiClient;
  List<Deposite> _deposites = [];

  DepositeRepository({@required this.depositeApiClient});

  Future getDeposites() async {
    _deposites = await depositeApiClient.fetchDeposites();
  }

  List<Lpgmc> get deposites {
    return List.from(_deposites);
  }

  List<DropdownMenuItem<Deposite>> getDropdownMenuItems() {
    List<DropdownMenuItem<Deposite>> items = List();

    for (Deposite deposite in _deposites) {
      items.add(DropdownMenuItem(
        value: deposite,
        child: Text(deposite.name),
      ));
    }
    return items;
  }
}
