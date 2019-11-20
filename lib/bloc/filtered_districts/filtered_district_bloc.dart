import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/bloc/district/district.dart';
import 'package:npa_user/model/models.dart';
import './filtered_districts.dart';

class FiltereddistrictBloc
    extends Bloc<FilteredDistrictEvent, FilteredDistrictState> {
  final DistrictBloc districtBloc;
  StreamSubscription districtsSubscription;

  FiltereddistrictBloc({@required this.districtBloc}) {
    // districtsSubscription = districtBloc
    //   ..listen((state) {
    //     if (state is DistrictsLoaded) {
    //       dispatch(UpdateDistricts(
    //           (districtBloc.state as DistrictsLoaded).districts));
    //     }
    //   });
  }

  @override
  FilteredDistrictState get initialState {
    return districtBloc.state is DistrictsLoaded
        ? FilteredDistrictsLoaded(
            (districtBloc.state as DistrictsLoaded).districts, Region())
        : FilteredDistrictsLoading();
  }

  @override
  Stream<FilteredDistrictState> mapEventToState(
    FilteredDistrictEvent event,
  ) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateDistricts) {
      yield* _mapDistrictsUpdateToState(event);
    }
  }

  Stream<FilteredDistrictState> _mapUpdateFilterToState(
      UpdateFilter event) async* {
    if (districtBloc.state is DistrictsLoaded) {
      yield FilteredDistrictsLoaded(
          _mapDistrictsToFilteredDistricts(
              (districtBloc.state as DistrictsLoaded).districts,
              event.regionFilter),
          event.regionFilter);
    }
  }

  Stream<FilteredDistrictState> _mapDistrictsUpdateToState(
      UpdateDistricts event) async* {
    final filter = state is FilteredDistrictsLoaded
        ? (state as FilteredDistrictsLoaded).activeFilter
        : 1;

    yield FilteredDistrictsLoaded(
        _mapDistrictsToFilteredDistricts(
            (districtBloc.state as DistrictsLoaded).districts, filter),
        filter);
  }

  List<DropdownMenuItem<District>> _mapDistrictsToFilteredDistricts(
      List<DropdownMenuItem<District>> districts, Region filter) {
    return districts.where((district) {
      // return districts.where((test) {
      //   return test.value.id == filter.id;
      // });
    }).toList();
  }

  @override
  Future<void> close() {
    districtsSubscription.cancel();
    // return super.close();
  }
}
