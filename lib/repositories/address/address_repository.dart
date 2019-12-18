import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/address/address.dart';

class AddressRepository {
  final AddressApiClient addressApiClient;

  AddressRepository({@required this.addressApiClient});
  List<Address> _addresses = [];

  Future<void> getAddresses({@required int id}) async {
    _addresses = await addressApiClient.fetchAddresses(id: id);
  }

  Future<void> addNewAddresses(
      {@required int consumerId,
      @required String houseNumber,
      @required String streetName,
      @required String residentialAddress,
      @required int districtId,
      @required String ghanaPostGpsaddress}) async {
    await addressApiClient.addNewAddress(
      consumerId: consumerId,
      houseNumber: houseNumber,
      streetName: streetName,
      residentialAddress: residentialAddress,
      districtId: districtId,
      ghanaPostGpsaddress: ghanaPostGpsaddress,
    );
  }

  List<Address> get addresses {
    return List.from(_addresses);
  }

  addAddress(Address address) {
    _addresses.add(address);
  }
}
