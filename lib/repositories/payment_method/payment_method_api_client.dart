import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

class PaymentMethodApiClient {
  static const baseUrl = "http://173.248.135.167/NpaTest";
  final http.Client httpClient;

  PaymentMethodApiClient({@required this.httpClient})
      : assert(httpClient != null);

  Future<List<PaymentMethod>> fetchPaymentMethods() async {
    final paymentMethodsUrl = "$baseUrl/api/PaymentMethodApi/PaymentMethods";
    final paymentMethodsResponse = await this.httpClient.get(paymentMethodsUrl);

    if (paymentMethodsResponse.statusCode != 200) {
      print(paymentMethodsResponse.statusCode);
      throw Exception('error getting paymentMethods');
    }

    final reponse = jsonDecode(paymentMethodsResponse.body);
    var paymentMethods = reponse["model"];
    List<PaymentMethod> paymentMethodList = [];

    for (var d in paymentMethods) {
      paymentMethodList.add(PaymentMethod.fromJson(d));
    }

    return paymentMethodList;
  }
}
