import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:npa_user/repositories/district/district.dart';
import './district.dart';

class DistrictBloc extends Bloc<DistrictEvent, DistrictState> {
  final DistrictRepository districtRepository;

  DistrictBloc({@required this.districtRepository})
      : assert(districtRepository != null);
  @override
  DistrictState get initialState => DistrictsLoading();

  @override
  Stream<DistrictState> mapEventToState(
    DistrictEvent event,
  ) async* {
    if (event is FetchDistricts) {
      yield DistrictsLoading();

      try {
        await districtRepository.getDistricts();
        final districts = districtRepository.getDropdownMenuItem();
        yield DistrictsLoaded(districts);
      } catch (e) {
        yield DistrictsError(e.toString());
      }
    }
  }
}
