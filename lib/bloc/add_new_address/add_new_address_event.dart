import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AddNewAddressEvent extends Equatable {
  AddNewAddressEvent();
}

class FetchAddNewAddresseApis extends AddNewAddressEvent {
  @override
  String toString() {
    return "FetchAddNewAddresseApis";
  }
}

class AddNewAddress extends AddNewAddressEvent {
  final int consumerId;
  final String houseNumber;
  final String streetName;
  final String residentialAddress;
  final int districtId;
  final String ghanaPostGpsaddress;

  AddNewAddress(
      {@required this.consumerId,
      @required this.houseNumber,
      @required this.streetName,
      @required this.residentialAddress,
      @required this.districtId,
      @required this.ghanaPostGpsaddress});

  @override
  String toString() {
    return "AddNewAddress";
  }
}
