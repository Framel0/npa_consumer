import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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

class AddressApiLoading extends AddressState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "AddressApiLoading";
  }
}

class AddressApiLoaded extends AddressState {
  final List<DropdownMenuItem<District>> districts;
  final List<Region> regions;

  AddressApiLoaded({@required this.districts, @required this.regions});

  @override
  List<Object> get props => [districts, regions];

  @override
  String toString() {
    return "AddressApiLoaded";
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
