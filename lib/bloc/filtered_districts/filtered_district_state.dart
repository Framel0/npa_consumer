import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';

abstract class FilteredDistrictState extends Equatable {
  FilteredDistrictState([List props = const []]) : super(props);
}

class FilteredDistrictsLoading extends FilteredDistrictState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "FilteredDistrictsLoading";
  }
}

class FilteredDistrictsLoaded extends FilteredDistrictState {
  final List<DropdownMenuItem<District>> filteredDistricts;
  final Region activeFilter;

  FilteredDistrictsLoaded(this.filteredDistricts, this.activeFilter);

  @override
  List<Object> get props => [filteredDistricts];

  @override
  String toString() {
    return "FilteredDistrictsLoaded";
  }
}
