
class Address {
  final int id;
  final String houseNumber;
  final String streetName;
  final String residentialAddress;
  final String ghanaPostGpsAddress;

  Address(
      {this.id,
      this.houseNumber,
      this.streetName,
      this.residentialAddress,
      this.ghanaPostGpsAddress});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        id: json["id"],
        houseNumber: json["houseNumber"],
        streetName: json["streetName"],
        residentialAddress: json["residentialAddress"],
        ghanaPostGpsAddress: json["ghanaPostGpsaddress"]);
  }
}
