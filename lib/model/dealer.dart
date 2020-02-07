class Dealer {
  int id;
  String dealerCode;
  String firstName;
  String lastName;
  String phoneNumber;
  String address;
  double latitude;
  double longitude;

  Dealer(
      {this.id,
      this.dealerCode,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.address,
      this.latitude,
      this.longitude});

  factory Dealer.fromJson(Map<String, dynamic> json) {
    return Dealer(
        id: json["id"],
        dealerCode: json["dealerCode"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"]);
  }
}
