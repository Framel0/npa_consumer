import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AddressEvent extends Equatable {
  AddressEvent([List props = const []]) : super(props);
}

class FetchAddresses extends AddressEvent {
  final int id;

  FetchAddresses({@required this.id});
  @override
  String toString() {
    return "Fetch Addresses";
  }
}

class FetchAddresseApis extends AddressEvent {
  @override
  String toString() {
    return "FetchAddresseApis";
  }
}

class AddNewAddress extends AddressEvent {
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
