import 'package:npa_user/model/models.dart';

class UpcomingRequest {
  final int id;
  final String date;
  final String consumerId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String houseNumber;
  final String streetName;
  final String residentialAddress;
  final String ghanaPostGpsaddress;
  final int deliveryMethodId;
  final String deliveryMethod;
  final int paymentMethodId;
  final String paymentMethod;

  UpcomingRequest(
      {this.id,
      this.date,
      this.consumerId,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.houseNumber,
      this.streetName,
      this.residentialAddress,
      this.ghanaPostGpsaddress,
      this.deliveryMethodId,
      this.deliveryMethod,
      this.paymentMethodId,
      this.paymentMethod});

  factory UpcomingRequest.fromJson(Map<String, dynamic> json) {
    return UpcomingRequest(
      id: json["id"],
      date: json["date"],
      consumerId: json["consumerId"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      phoneNumber: json["phoneNumber"],
      houseNumber: json["houseNumber"],
      streetName: json["streetName"],
      residentialAddress: json["residentialAddress"],
      ghanaPostGpsaddress: json["ghanaPostGpsaddress"],
      deliveryMethodId: json["deliveryMethodId"],
      deliveryMethod: json["deliveryMethod"],
      paymentMethodId: json["paymentMethodId"],
      paymentMethod: json["paymentMethod"],
    );
  }
}
