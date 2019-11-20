class Dealer {
  int id;
  String ventureName;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String address;
  double latitude;
  double longitude;

  Dealer(
      {this.id,
      this.ventureName,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.address,
      this.latitude,
      this.longitude});

  Dealer.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    ventureName = json["ventureName"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    phoneNumber = json["phoneNumber"];
    email = json["email"];
    address = json["currentAddress"];
    latitude = json["latitude"];
    longitude = json["longitude"];
  }
}
