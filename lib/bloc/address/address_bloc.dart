import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/repositories/repositories.dart';
import './address.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository addressRepository;
  final DistrictRepository districtRepository;
  final RegionRepository regionRepository;

  AddressBloc(
      {@required this.districtRepository,
      @required this.regionRepository,
      @required this.addressRepository});
  @override
  AddressState get initialState => AddressLoading();

  @override
  Stream<AddressState> mapEventToState(
    AddressEvent event,
  ) async* {
    if (event is FetchAddresses) {
      yield AddressLoading();

      try {
        await addressRepository.getAddresses(id: event.id);
        final addresses = addressRepository.addresses;
        yield AddressLoaded(addresses: addresses);
      } catch (e) {
        yield AddressError(error: e.toString());
      }
    }
    if (event is FetchAddresseApis) {
      yield AddressApiLoading();

      try {
        await districtRepository.getDistricts();
        final districts = districtRepository.getDropdownMenuItem();

        await regionRepository.getRegions();
        final regions = regionRepository.regions;
        yield AddressApiLoaded(districts: districts, regions: regions);
        yield AddressLoading();
      } catch (e) {
        yield AddressError(error: e.toString());
      }
    }
    if (event is AddNewAddress) {
      yield AddressLoading();

      try {
        await addressRepository.addNewAddresses(
          consumerId: event.consumerId,
          houseNumber: event.houseNumber,
          streetName: event.streetName,
          residentialAddress: event.residentialAddress,
          districtId: event.districtId,
          ghanaPostGpsaddress: event.ghanaPostGpsaddress,
        );
        yield AddressSuccess();
      } catch (e) {
        yield AddressError(error: e.toString());
      }
    }
  }
}
