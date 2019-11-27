import 'package:equatable/equatable.dart';

abstract class AddressEvent extends Equatable {
  AddressEvent([List props = const []]) : super(props);
}

class FetchAddresses extends AddressEvent {
  @override
  String toString() {
    return "Fetch Addresses";
  }
}
