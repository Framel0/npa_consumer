import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';

abstract class FilteredDistrictEvent extends Equatable {
  FilteredDistrictEvent([List props = const []]) : super(props);
}

class UpdateFilter extends FilteredDistrictEvent {
  final Region regionFilter;

  UpdateFilter(this.regionFilter);

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "UpdateFilter";
  }
}

class UpdateDistricts extends FilteredDistrictEvent {
  final List<DropdownMenuItem<District>> districts;

  UpdateDistricts(this.districts);

  @override
  List<Object> get props => [districts];

  @override
  String toString() {
    return "UpdateDistricts { district: $districts }";
  }
}
