import 'package:npa_user/model/models.dart';

class AddressRepository {
  List<Address> _addresses = [
    Address(
        id: 1,
        region: Region(),
        district: District(),
        residential: "Dworwulu",
        gps: "NPACR-321419"),
    Address(
        id: 2,
        region: Region(),
        district: District(),
        residential: "East egon",
        gps: "NPACR-321419"),
  ];

  List<Address> get getAddresses {
    return List.from(_addresses);
  }

  addAddress(Address address) {
    _addresses.add(address);
  }

  updateAddress(Address updateAddress) {
    var address = _addresses.firstWhere((address) {
      address.id == updateAddress.id;
    });
    address.region = updateAddress.region;
    address.district = updateAddress.district;
    address.residential = updateAddress.residential;
    address.gps = updateAddress.gps;
  }
}
