import 'package:npa_user/model/models.dart';

class UpcomingRequest {
  int id;
  PaymentMethod paymentMethod;
  DeliveryMethod deliveryMethod;

  UpcomingRequest({this.id, this.paymentMethod, this.deliveryMethod});

  factory UpcomingRequest.fromJson(Map<String, dynamic> json) {
    return UpcomingRequest(
      id: json["id"],
      deliveryMethod: DeliveryMethod.fromJson(json["deliveryMethod"]),
      paymentMethod: PaymentMethod.fromJson(json["paymentMethod"]),
    );
  }
}
