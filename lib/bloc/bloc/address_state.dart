import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

abstract class AddressState extends Equatable {
  AddressState([List props = const []]) : super(props);
}

class AddressLoading extends AddressState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "AddressLoading";
  }
}

class AddressLoaded extends AddressState {
  final List<Address> addresses;

  AddressLoaded({@required this.addresses});
  @override
  List<Object> get props => [addresses];

  @override
  String toString() {
    return "AddressLoaded";
  }
}

class AddressError extends AddressState {
  final String error;

  AddressError({@required this.error});
  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return "AddressError";
  }
}
