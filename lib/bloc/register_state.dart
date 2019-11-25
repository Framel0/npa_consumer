import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';

abstract class RegisterState extends Equatable {
  RegisterState([List props = const []]) : super(props);
}

class InitialRegisterState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoading extends RegisterState {
  @override
  String toString() {
    return "Register Loading";
  }
}

class RegisterApiLoading extends RegisterState {
  @override
  String toString() {
    return "RegisterApiLoading";
  }
}

class RegisterLoaded extends RegisterState {
  @override
  String toString() {
    return "Register Loading";
  }
}

class RegisterApiLoaded extends RegisterState {
  final List<DropdownMenuItem<District>> districts;
  final List<Region> regions;
  final List<DropdownMenuItem<Lpgmc>> lpgmcs;
  final List<DropdownMenuItem<Deposite>> deposites;
  final List<DropdownMenuItem<CylinderSize>> cylinderSizes;

  RegisterApiLoaded(
      {@required this.districts,
      @required this.regions,
      @required this.lpgmcs,
      @required this.deposites,
      @required this.cylinderSizes});

  @override
  String toString() {
    return "Register Loading";
  }
}

class RegisterFailuer extends RegisterState {
  final String error;

  RegisterFailuer({@required this.error}) : super([error]);

  @override
  String toString() {
    return "Register Failure {error : $error}";
  }
}

class RegisterSuccess extends RegisterState {
  RegisterSuccess();

  @override
  String toString() {
    return "RegisterSuccess";
  }
}
