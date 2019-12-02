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
