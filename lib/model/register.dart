import 'package:flutter/material.dart';

class Register {
  final String dateOfRegistration;
  final String consumerId;
  final String name;
  final String residentialAddress;
  final String gpsAddress;
  final String phoneNumber;
  final String numberOfCylinders;
  final String sizesOfCylinder;
  final String serialNumberOfCylinders;
  final String dealer;

  Register(
      {@required this.dateOfRegistration,
      @required this.consumerId,
      @required this.name,
      this.residentialAddress,
      @required this.gpsAddress,
      @required this.phoneNumber,
      @required this.numberOfCylinders,
      @required this.sizesOfCylinder,
      @required this.serialNumberOfCylinders,
      @required this.dealer});
}
