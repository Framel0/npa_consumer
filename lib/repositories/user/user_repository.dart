import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/data/consumer_info.dart';
import 'package:npa_user/model/models.dart';
import 'package:http/http.dart' as http;
import 'package:npa_user/repositories/user/user.dart';

class UserRepository {
  final UserApiClient userApiClient = UserApiClient(httpClient: http.Client());
  final storage = new FlutterSecureStorage();
  final String tokenKey = "cghMOrBKfN97FbG8661ztXwvaS46gnjz_EAl5vYdzyA=";

  Future<User> authenticate({
    @required String phoneNumber,
    @required String password,
    @required String firebaseToken,
  }) async {
    User user = await userApiClient.login(
      phoneNumber: phoneNumber,
      password: password,
      firebaseToken: firebaseToken,
    );
    await saveData(user);
    return user;
  }

  Future<User> getUserInfo({
    @required int userId,
  }) async {
    User user = await userApiClient.getUserInfo(userId: userId);
    await saveData(user);
    return user;
  }

  Future updateFirebaseToken({
    @required int userId,
    @required String firebaseToken,
  }) async {
    await userApiClient.updateFirebaseToken(
      userId: userId,
      firebaseToken: firebaseToken,
    );
  }

  Future<void> register({
    @required String firstName,
    @required String lastName,
    @required int dealerId,
    @required String phoneNumber,
    @required String password,
    @required String houseNumber,
    @required String streetName,
    @required String residentialAddress,
    @required String ghanaPostGpsaddress,
    @required int districtId,
    @required int depositeId,
    @required int productId,
    @required int registrationType,
    @required double latitude,
    @required double longitude,
    @required String firebaseToken,
  }) async {
    await userApiClient.register(
        firstName: firstName,
        lastName: lastName,
        dealerId: dealerId,
        phoneNumber: phoneNumber,
        password: password,
        houseNumber: houseNumber,
        streetName: streetName,
        residentialAddress: residentialAddress,
        ghanaPostGpsaddress: ghanaPostGpsaddress,
        districtId: districtId,
        depositeId: depositeId,
        productId: productId,
        registrationType: registrationType,
        latitude: latitude,
        longitude: longitude,
        firebaseToken: firebaseToken);
    // await Future.delayed(Duration(seconds: 3));
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
