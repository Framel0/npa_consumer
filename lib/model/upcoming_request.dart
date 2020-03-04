import 'package:npa_user/model/models.dart';
import 'package:npa_user/model/request_product.dart';

class UpcomingRequest {
  int id;
  DateTime date;
  String consumerCode;
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
  String dispatchCode;
  String dispatchFirstName;
  String dispatchLastName;
  String dispatchPhoneNumber;
  String status;
  int statusId;
  List<RequestProduct> products;

  UpcomingRequest(
      {this.id,
      this.date,
      this.consumerCode,
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

  UpcomingRequest.fromJson(Map<String, dynamic> json) {
    // return UpcomingRequest(
    id = json["id"];
    String dateTime = json["date"];
    date = DateTime.parse(dateTime);
    consumerCode = json["consumerCode"];
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
    dispatchCode = json["dispatchCode"];
    dispatchFirstName = json["dispatchFirstName"];
    dispatchLastName = json["dispatchLastName"];
    dispatchPhoneNumber = json["dispatchPhoneNumber"];
    status = json["status"];
    statusId = json["statusId"];
    var list = json["consumerRefillRequestProduct"] as List;
    products = list.map((i) => RequestProduct.fromJson(i)).toList();
  }
}
