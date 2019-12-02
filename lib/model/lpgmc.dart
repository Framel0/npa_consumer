class Lpgmc {
  final int id;
  final String name;
  final String address;
  final String email;
  final String phoneNumber;
  final String city;

  Lpgmc(
      {this.id,
      this.name,
      this.address,
      this.email,
      this.phoneNumber,
      this.city});

  factory Lpgmc.fromJson(Map<String, dynamic> json) {
    return Lpgmc(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        email: json["email"],
        phoneNumber: json["phoneNumber"]);
  }
}
