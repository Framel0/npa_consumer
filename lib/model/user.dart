class User {
  final int id;
  final String consumerId;
  final String dateOfRegistration;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final int dealerId;
  final int depositeId;
  final int statusId;
  final String token;

  User(
      {this.id,
      this.consumerId,
      this.dateOfRegistration,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.dealerId,
      this.depositeId,
      this.statusId,
      this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        consumerId: json["consumerId"],
        dateOfRegistration: json["dateOfRegistration"],
        firstName: json['firstName'],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        dealerId: json["dealerId"],
        depositeId: json["depositeId"],
        statusId: json["statusId"],
        token: json["token"]);
  }
}
