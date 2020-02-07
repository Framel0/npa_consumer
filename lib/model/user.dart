class User {
  final int id;
  final String consumerCode;
  final String dateOfRegistration;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final int dealerId;
  final int depositId;
  final int statusId;
  final String token;

  User(
      {this.id,
      this.consumerCode,
      this.dateOfRegistration,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.dealerId,
      this.depositId,
      this.statusId,
      this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        consumerCode: json["consumerCode"],
        dateOfRegistration: json["dateOfRegistration"],
        firstName: json['firstName'],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        dealerId: json["dealerId"],
        depositId: json["depositeId"],
        statusId: json["statusId"],
        token: json["token"]);
  }
}
