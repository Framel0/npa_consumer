import 'package:npa_user/model/request_product.dart';

class RequestHistory {
  int id;
  String date;
  String consumerId;
  String firstName;
  String lastName;
  String phoneNumber;
  String houseNumber;
  String streetName;
  String residentialAddress;
  String ghanaPostGpsaddress;
  int deliveryMethodId;
  String deliveryMethod;
  int paymentMethodId;
  String paymentMethod;
  String dispatchId;
  String dispatchFirstName;
  String dispatchLastName;
  String dispatchPhoneNumber;
  int statusId;
  List<RequestProduct> products;

  RequestHistory(
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
      this.paymentMethod,
      this.products});

  RequestHistory.fromJson(Map<String, dynamic> json) {
    // return UpcomingRequest(
    id = json["id"];
    date = json["date"];
    consumerId = json["consumerId"];
    firstName = json["consumerFirstName"];
    lastName = json["consumerLastName"];
    phoneNumber = json["consumerPhoneNumber"];
    houseNumber = json["houseNumber"];
    streetName = json["streetName"];
    residentialAddress = json["residentialAddress"];
    ghanaPostGpsaddress = json["ghanaPostGpsaddress"];
    deliveryMethodId = json["deliveryMethodId"];
    deliveryMethod = json["deliveryMethod"];
    paymentMethodId = json["paymentMethodId"];
    paymentMethod = json["paymentMethod"];
    dispatchId = json["dispatchId"];
    dispatchFirstName = json["dispatchFirstName"];
    dispatchLastName = json["dispatchLastName"];
    dispatchPhoneNumber = json["dispatchPhoneNumber"];
    statusId = json["statusId"];
    var list = json["consumerRefillRequestProduct"] as List;
    products = list.map((i) => RequestProduct.fromJson(i)).toList();
  }
}
