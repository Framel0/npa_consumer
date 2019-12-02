import 'package:npa_user/model/refill_request_product.dart';

class RefillRequest {
  int consumerId;
  int consmerAddressId;
  int paymentMethodId;
  int deliveryMethodId;
  List<RefillRequestProduct> refillRequestProducts;

  Map<String, dynamic> toJson() => {
        "consumerId": consumerId,
        "consmerAddressId": consmerAddressId,
        "paymentMethodId": paymentMethodId,
        "deliveryMethodId": deliveryMethodId,
        "consumerRefillRequestProduct":
            refillRequestProducts.map((p) => p.toJson()).toList()
      };
}
