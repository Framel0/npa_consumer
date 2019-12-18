import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';

class AddressApiClient {
  static const baseUrl = "http://173.248.135.167/NpaTest";
  final http.Client httpClient;

  AddressApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Address>> fetchAddresses({@required int id}) async {
    final addresssUrl =
        "$baseUrl/api/ConsumerAddresseApi/ConsumerAddressesByConsumer/$id";
    final addresssResponse = await this.httpClient.get(addresssUrl);

    if (addresssResponse.statusCode != 200) {
      print(addresssResponse.statusCode);
      throw Exception('error getting addresss');
    }

    final reponse = jsonDecode(addresssResponse.body);
    var addresss = reponse["model"];
    List<Address> addressList = [];
    for (var d in addresss) {
      addressList.add(Address.fromJson(d));
    }

    return addressList;
  }

  Future<void> addNewAddress(
      {@required int consumerId,
      @required String houseNumber,
      @required String streetName,
      @required String residentialAddress,
      @required int districtId,
      @required String ghanaPostGpsaddress}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "consumerId": consumerId,
      "houseNumber": houseNumber,
      "streetName": streetName,
      "residentialAddress": residentialAddress,
      "districtId": districtId,
      "ghanaPostGpsaddress": ghanaPostGpsaddress
    });
    final addressUrl = "$baseUrl/api/ConsumerAddresseApi/Create";
    final addresssResponse =
        await this.httpClient.post(addressUrl, headers: headers, body: body);

    if (addresssResponse.statusCode != 200) {
      print(addresssResponse.statusCode);
      throw Exception('error getting addresss');
    }

    final reponse = jsonDecode(addresssResponse.body);
  }
}