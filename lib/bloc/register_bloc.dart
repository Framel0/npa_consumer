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
  final CylinderRepository cylinderRepository;

  RegisterBloc(
      {@required this.lpgmcRepository,
      @required this.districtRepository,
      @required this.regionRepository,
      @required this.depositeRepository,
      @required this.cylinderRepository,
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
        userRepository.register(
          firstName: event.firstName,
          lastName: event.lastName,
          phoneNumber: event.phoneNumber,
          password: event.password,
          consumerId: event.consumerId,
          residentialAddress: event.residentialAddress,
          latitude: event.latitude,
          longitude: event.longitude,
          dealerId: event.dealerId,
        );
      } catch (e) {
        RegisterFailuer(error: e.toString());
      }
    }
    if (event is FetchAll) {
      yield RegisterLoading();

      try {
        districtRepository.getDistricts();
        regionRepository.getRegions();
        lpgmcRepository.getLpgmcs();
        depositeRepository.getDeposites();
        cylinderRepository.getCylinders();
      } catch (ex) {
        RegisterFailuer(error: ex.toString());
      }
    }
  }
}
