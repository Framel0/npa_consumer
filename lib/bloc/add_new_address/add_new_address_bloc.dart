import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/repositories/repositories.dart';
import './add_new_address.dart';

class AddNewAddressBloc extends Bloc<AddNewAddressEvent, AddNewAddressState> {
  final AddressRepository addressRepository;
  final DistrictRepository districtRepository;
  final RegionRepository regionRepository;

  AddNewAddressBloc(
      {@required this.districtRepository,
      @required this.regionRepository,
      @required this.addressRepository});

  @override
  AddNewAddressState get initialState => AddNewAddressLoading();

  @override
  Stream<AddNewAddressState> mapEventToState(
    AddNewAddressEvent event,
  ) async* {
    if (event is FetchAddNewAddresseApis) {
      yield AddNewAddressApiLoading();

      try {
        await districtRepository.getDistricts();
        final districts = districtRepository.getDropdownMenuItem();

        await regionRepository.getRegions();
        final regions = regionRepository.regions;
        yield AddNewAddressApiLoaded(districts: districts, regions: regions);
      } catch (e) {
        yield AddNewAddressError(error: e.toString());
      }
    }

    if (event is AddNewAddress) {
      yield AddNewAddressLoading();

      try {
        await addressRepository.addNewAddresses(
          consumerId: event.consumerId,
          houseNumber: event.houseNumber,
          streetName: event.streetName,
          residentialAddress: event.residentialAddress,
          districtId: event.districtId,
          ghanaPostGpsaddress: event.ghanaPostGpsaddress,
        );
        yield AddNewAddressSuccess();
      } catch (e) {
        yield AddNewAddressError(error: e.toString());
      }
    }
  }
}
