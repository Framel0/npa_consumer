import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/data/consumer_info.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/repositories.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final UserApiClient userApiClient = UserApiClient(httpClient: http.Client());
  final storage = new FlutterSecureStorage();
  final String tokenKey = "cghMOrBKfN97FbG8661ztXwvaS46gnjz_EAl5vYdzyA=";

  Future<String> authenticate({
    @required String phoneNumber,
    @required String password,
  }) async {
    User user =
        await userApiClient.login(phoneNumber: phoneNumber, password: password);
    saveData(user);
    return user.token;
  }

  Future<void> register({
    @required String dateOfRegistration,
    @required String firstName,
    @required String lastName,
    @required int lpgmcId,
    @required int dealerId,
    @required String phoneNumber,
    @required String consumerId,
    @required String password,
    @required String houseNumber,
    @required String streetName,
    @required String residentialAddress,
    @required String ghanaPostGpsaddress,
    @required int districtId,
    @required int regionId,
    @required int depositeId,
    @required int cylinderSizeId,
    @required int statusId,
    @required double latitude,
    @required double longitude,
  }) async {
    await userApiClient.register(
      dateOfRegistration: dateOfRegistration,
      firstName: firstName,
      lastName: lastName,
      lpgmcId: lpgmcId,
      dealerId: dealerId,
      phoneNumber: phoneNumber,
      password: password,
      consumerId: consumerId,
      houseNumber: houseNumber,
      streetName: streetName,
      residentialAddress: residentialAddress,
      ghanaPostGpsaddress: ghanaPostGpsaddress,
      districtId: districtId,
      regionId: regionId,
      depositeId: depositeId,
      cylinderSizeId: cylinderSizeId,
      statusId: statusId,
      latitude: latitude,
      longitude: longitude,
    );
    await Future.delayed(Duration(seconds: 3));
  }

  Future<void> saveData(User user) async {
    await saveUserData(user);
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await storage.delete(key: tokenKey);
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await storage.write(key: tokenKey, value: token);
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    String value = await storage.read(key: tokenKey);
    if (value != null) {
      return true;
    }

    return false;
  }
}
