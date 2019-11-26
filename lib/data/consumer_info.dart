import 'package:npa_user/model/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

final idKey = "id";
final consumerIdKey = "consumer_id";
final firstNameKey = "first_name";
final lastNameKey = "last_name";
final phoneNumberKey = "phone_number";

Future<User> readUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final id = prefs.getInt(idKey) ?? 0;
  final consumerId = prefs.getString(consumerIdKey) ?? "";
  final firstName = prefs.getString(firstNameKey) ?? "";
  final lastName = prefs.getString(lastNameKey) ?? "";
  final phoneNumber = prefs.getString(phoneNumberKey) ?? "";

  var user = User(
      id: id,
      consumerId: consumerId,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber);

  return user;
}

Future<void> saveUserData(User user) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt(idKey, user.id);
  prefs.setString(consumerIdKey, user.consumerId);
  prefs.setString(firstNameKey, user.firstName);
  prefs.setString(lastNameKey, user.lastName);
  prefs.setString(phoneNumberKey, user.phoneNumber);
}
