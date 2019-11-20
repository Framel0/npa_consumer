import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
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
    // String token =
    //     await userApiClient.login(phoneNumber: phoneNumber, password: password);
    await Future.delayed(Duration(seconds: 3));
    return "token";
  }

  Future<void> register({
    @required String firstName,
    @required String lastName,
    @required String phoneNumber,
    @required String password,
    @required String consumerId,
    @required String residentialAddress,
    @required double latitude,
    @required double longitude,
    @required int dealerId,
  }) async {
    // userApiClient.register(
    //   firstName: firstName,
    //   lastName: lastName,
    //   phoneNumber: phoneNumber,
    //   password: password,
    //   consumerId: consumerId,
    //   residentialAddress: residentialAddress,
    //   latitude: latitude,
    //   longitude: longitude,
    //   dealerId: dealerId,
    // );
    await Future.delayed(Duration(seconds: 3));
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
