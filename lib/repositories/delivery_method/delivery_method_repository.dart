import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/delivery_method/delivery_method.dart';

class DeliveryMethodRepository {
  final DeliveryMethodApiClient deliveryMethodApiClient;

  List<DeliveryMethod> _deliveryMethods = [];
  DeliveryMethodRepository({@required this.deliveryMethodApiClient})
      : assert(deliveryMethodApiClient != null);

  Future<void> getDeliveryMethods() async {
    _deliveryMethods = await deliveryMethodApiClient.fetchDeliveryMethods();
  }

  List<DeliveryMethod> get deliveryMethods {
    return List.from(_deliveryMethods);
  }

  List<DropdownMenuItem<DeliveryMethod>> getDropdownMenuItems() {
    List<DropdownMenuItem<DeliveryMethod>> items = List();

    for (DeliveryMethod deliveryMethod in _deliveryMethods) {
      items.add(DropdownMenuItem(
        value: deliveryMethod,
        child: Text(deliveryMethod.name),
      ));
    }

    return items;
  }

  List<DropdownMenuItem<DeliveryMethod>> getDropdownMenuItem() {
    List<DropdownMenuItem<DeliveryMethod>> items = List();

    for (DeliveryMethod deliveryMethod in _deliveryMethods) {
      items.add(DropdownMenuItem(
        value: deliveryMethod,
        child: Text(deliveryMethod.name),
      ));
    }

    return items;
  }
}
