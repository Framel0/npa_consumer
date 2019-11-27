import 'package:npa_user/model/refill_request_product.dart';

class RefillRequest {
  int consumerId;
  int paymentMethodId;
  int deliveryMethodId;
  List<RefillRequestProduct> refillRequestProducts;
}
