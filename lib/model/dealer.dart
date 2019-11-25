class Dealer {
  int id;
  String firstName;
  String lastName;
  String phoneNumber;
  String address;
  double latitude;
  double longitude;

  Dealer(
      {this.id,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.address,
      this.latitude,
      this.longitude});

  Dealer.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    phoneNumber = json["phoneNumber"];
    address = json["address"];
    latitude = json["latitude"];
    longitude = json["longitude"];
  }
}
