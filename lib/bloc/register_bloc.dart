import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:npa_user/repositories/repositories.dart';
import './bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final LpgmcRepository lpgmcRepository;
  final DistrictRepository districtRepository;
  final RegionRepository regionRepository;
  final DepositeRepository depositeRepository;
  final CylinderSizeRepository cylinderSizeRepository;

  RegisterBloc(
      {@required this.lpgmcRepository,
      @required this.districtRepository,
      @required this.regionRepository,
      @required this.depositeRepository,
      @required this.cylinderSizeRepository,
      @required this.userRepository});
  @override
  RegisterState get initialState => InitialRegisterState();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterButtonPressed) {
      yield RegisterLoading();
      try {
        await userRepository.register(
          dateOfRegistration: event.dateOfRegistration,
          firstName: event.firstName,
          lastName: event.lastName,
          lpgmcId: event.lpgmcId,
          dealerId: event.dealerId,
          phoneNumber: event.phoneNumber,
          password: event.password,
          consumerId: event.consumerId,
          houseNumber: event.houseNumber,
          streetName: event.streetName,
          residentialAddress: event.residentialAddress,
          districtId: event.districtId,
          regionId: event.regionId,
          depositeId: event.depositeId,
          cylinderSizeId: event.cylinderSizeId,
          statusId: event.statusId,
          ghanaPostGpsaddress: event.ghanaPostGpsaddress,
          latitude: event.latitude,
          longitude: event.longitude,
        );

        yield RegisterSuccess();
      } catch (e) {
        RegisterFailuer(error: e.toString());
      }
    }
    if (event is FetchAll) {
      yield RegisterApiLoading();

      try {
        await districtRepository.getDistricts();
        final districts = districtRepository.getDropdownMenuItems();

        await regionRepository.getRegions();
        final regions = regionRepository.regions;

        await lpgmcRepository.getLpgmcs();
        final lpgmcs = lpgmcRepository.getDropdownMenuItems();

        await depositeRepository.getDeposites();
        final deposites = depositeRepository.getDropdownMenuItems();

        await cylinderSizeRepository.getCylinderSizes();
        final cylinderSizes = cylinderSizeRepository.getDropdownMenuItems();

        yield RegisterApiLoaded(
            districts: districts,
            regions: regions,
            lpgmcs: lpgmcs,
            deposites: deposites,
            cylinderSizes: cylinderSizes);
      } catch (ex) {
        RegisterFailuer(error: ex.toString());
      }
    }
  }
}
