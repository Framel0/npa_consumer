class User {
  int id;
  String firstName;
  String lastName;
  String phoneNumber;
  String password;
  String consumerId;
  String residentialAddress;
  String dateOfRegistration;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.password,
      this.consumerId,
      this.residentialAddress,
      this.dateOfRegistration});

  User.fromJson(Map<String, dynamic> json) {
    id = json[id];
    firstName = json[firstName];
    lastName = json[lastName];
    phoneNumber = json[phoneNumber];
    consumerId = json[consumerId];
    residentialAddress = json[residentialAddress];
    dateOfRegistration = json[dateOfRegistration];
  }

  Map toLoginMap() {
    var map = new Map<String, dynamic>();
    map["phoneNumber"] = phoneNumber;
    map["password"] = password;
    return map;
  }
}
