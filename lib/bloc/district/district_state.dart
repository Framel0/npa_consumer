import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';

abstract class DistrictState extends Equatable {
  DistrictState([List props = const []]) : super(props);
}

class DistrictsLoading extends DistrictState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "DistrictsLoading";
  }
}

class DistrictsLoaded extends DistrictState {
  final List<DropdownMenuItem<District>> districts;

  DistrictsLoaded(this.districts);

  @override
  List<Object> get props => [districts];

  @override
  String toString() {
    return "DistrictsLoaded";
  }
}

class DistrictsError extends DistrictState {
  final String error;

  DistrictsError(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return "DistrictsError { error: $error }";
  }
}
