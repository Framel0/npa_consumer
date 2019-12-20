import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';

abstract class AddNewAddressState extends Equatable {
  AddNewAddressState();
}

class AddNewAddressLoading extends AddNewAddressState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "";
  }
}

class AddNewAddressSuccess extends AddNewAddressState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "AddNewAddressSuccess";
  }
}

class AddNewAddressError extends AddNewAddressState {
  final String error;

  AddNewAddressError({@required this.error});

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "AddNewAddressError";
  }
}

class AddNewAddressApiLoading extends AddNewAddressState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "AddNewAddressApiLoading";
  }
}

class AddNewAddressApiLoaded extends AddNewAddressState {
  final List<DropdownMenuItem<District>> districts;
  final List<Region> regions;

  AddNewAddressApiLoaded({@required this.districts, @required this.regions});

  @override
  List<Object> get props => [districts, regions];

  @override
  String toString() {
    return "AddNewAddressApiLoaded";
  }
}
