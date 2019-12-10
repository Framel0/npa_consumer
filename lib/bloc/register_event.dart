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
  final int lpgmcId;
  final int dealerId;
  final String phoneNumber;
  final String consumerId;
  final String password;
  final String houseNumber;
  final String streetName;
  final String residentialAddress;
  final String ghanaPostGpsaddress;
  final int districtId;
  final int regionId;
  final int depositeId;
  final int statusId;
  final int cylinderSizeId;
  final double latitude;
  final double longitude;

  RegisterButtonPressed({
    this.depositeId,
    this.cylinderSizeId,
    this.lpgmcId,
    this.houseNumber,
    this.streetName,
    this.ghanaPostGpsaddress,
    this.districtId,
    this.regionId,
    this.statusId,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.password,
    this.consumerId,
    this.residentialAddress,
    this.latitude,
    this.longitude,
    this.dealerId,
  }) : super([
          lpgmcId,
          houseNumber,
          streetName,
          ghanaPostGpsaddress,
          districtId,
          regionId,
          statusId,
          firstName,
          lastName,
          phoneNumber,
          password,
          consumerId,
          residentialAddress,
          latitude,
          longitude,
          dealerId,
        ]);

  // RegisterButtonPressed(
  //     {this.fullName, this.email, this.phoneNumber, this.password})
  //     : super([fullName, email, phoneNumber, password]);

  @override
  String toString() {
    return """Register Button Pressed 
    """;
  }
}
