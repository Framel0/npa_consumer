import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/bloc/region/region.dart';
import 'package:npa_user/repositories/region/region.dart';

class RegionBloc extends Bloc<RegionEvent, RegionState> {
  final RegionRepository regionRepository;

  RegionBloc({@required this.regionRepository})
      : assert(regionRepository != null);
  @override
  RegionState get initialState => RegionLoading();

  @override
  Stream<RegionState> mapEventToState(
    RegionEvent event,
  ) async* {
    if (event is FetchRegions) {
      yield RegionLoading();

      try {
        await regionRepository.getRegions();

        final regions = regionRepository.regions;

        yield RegionLoaded(regions: regions);
      } catch (ex) {
        yield RegionError(error: ex.toString());
      }
    }
  }
}
