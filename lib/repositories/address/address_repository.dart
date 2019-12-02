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

  List<Address> get addresses {
    return List.from(_addresses);
  }

  addAddress(Address address) {
    _addresses.add(address);
  }
}
