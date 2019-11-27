import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/payment_method/payment_method.dart';

class PaymentMethodRepository {
  final PaymentMethodApiClient paymentMethodApiClient;

  List<PaymentMethod> _paymentMethods = [];
  PaymentMethodRepository({@required this.paymentMethodApiClient})
      : assert(paymentMethodApiClient != null);

  Future<void> getPaymentMethods() async {
    _paymentMethods = await paymentMethodApiClient.fetchPaymentMethods();
  }

  List<PaymentMethod> get paymentMethods {
    return List.from(_paymentMethods);
  }

  List<DropdownMenuItem<PaymentMethod>> getDropdownMenuItems() {
    List<DropdownMenuItem<PaymentMethod>> items = List();

    for (PaymentMethod paymentMethod in _paymentMethods) {
      items.add(DropdownMenuItem(
        value: paymentMethod,
        child: Text(paymentMethod.name),
      ));
    }

    return items;
  }

  List<DropdownMenuItem<PaymentMethod>> getDropdownMenuItem() {
    List<DropdownMenuItem<PaymentMethod>> items = List();

    for (PaymentMethod paymentMethod in _paymentMethods) {
      items.add(DropdownMenuItem(
        value: paymentMethod,
        child: Text(paymentMethod.name),
      ));
    }

    return items;
  }
}
