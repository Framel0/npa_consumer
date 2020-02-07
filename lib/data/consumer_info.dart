import 'package:npa_user/model/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

final idKey = "id";
final consumerIdKey = "consumer_id";
final dateOfRegistrationKey = "date_of_registration";
final firstNameKey = "first_name";
final lastNameKey = "last_name";
final phoneNumberKey = "phone_number";
final dealerIdKey = "dealer_id";
final depositeIdKey = "deposite_id";
final statusIdKey = "status_id";

Future<User> readUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final id = prefs.getInt(idKey) ?? 0;
  final consumerId = prefs.getString(consumerIdKey) ?? "";
  final dateOfRegistration = prefs.getString(dateOfRegistrationKey) ?? "";
  final firstName = prefs.getString(firstNameKey) ?? "";
  final lastName = prefs.getString(lastNameKey) ?? "";
  final phoneNumber = prefs.getString(phoneNumberKey) ?? "";
  final dealerId = prefs.getInt(dealerIdKey) ?? 0;
  final depositeId = prefs.getInt(depositeIdKey) ?? 0;
  final statusId = prefs.getInt(statusIdKey) ?? 0;

  var user = User(
    id: id,
    consumerCode: consumerId,
    dateOfRegistration: dateOfRegistration,
    firstName: firstName,
    lastName: lastName,
    phoneNumber: phoneNumber,
    dealerId: dealerId,
    depositId: depositeId,
    statusId: statusId,
  );

  return user;
}

Future<void> saveUserData(User user) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt(idKey, user.id);
  prefs.setString(consumerIdKey, user.consumerCode);
  prefs.setString(dateOfRegistrationKey, user.dateOfRegistration);
  prefs.setString(firstNameKey, user.firstName);
  prefs.setString(lastNameKey, user.lastName);
  prefs.setString(phoneNumberKey, user.phoneNumber);
  prefs.setInt(dealerIdKey, user.dealerId);
  prefs.setInt(depositeIdKey, user.depositId);
  prefs.setInt(statusIdKey, user.statusId);
}
