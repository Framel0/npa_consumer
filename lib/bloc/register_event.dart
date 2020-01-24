import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super(props);
}

class FetchAll extends RegisterEvent {
  @override
  String toString() {
    return "FetchAll";
  }
}

class RegisterButtonPressed extends RegisterEvent {
  final String firstName;
  final String lastName;
  final int dealerId;
  final String phoneNumber;
  final String consumerId;
  final String password;
  final String houseNumber;
  final String streetName;
  final String residentialAddress;
  final String ghanaPostGpsaddress;
  final int districtId;
  final int depositeId;
  final int productId;
  final double latitude;
  final double longitude;
  final String firebaseToken;

  RegisterButtonPressed({
    this.depositeId,
    this.productId,
    this.houseNumber,
    this.streetName,
    this.ghanaPostGpsaddress,
    this.districtId,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.password,
    this.consumerId,
    this.residentialAddress,
    this.latitude,
    this.longitude,
    this.dealerId,
    this.firebaseToken,
  }) : super([
          houseNumber,
          streetName,
          ghanaPostGpsaddress,
          districtId,
          firstName,
          lastName,
          phoneNumber,
          password,
          consumerId,
          residentialAddress,
          latitude,
          longitude,
          dealerId,
          firebaseToken,
        ]);

  @override
  String toString() {
    return """Register Button Pressed 
    """;
  }
}
