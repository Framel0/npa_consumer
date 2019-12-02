class DeliveryMethod {
  final int id;
  final String code;
  final String name;
  final double price;

  DeliveryMethod({this.id, this.code, this.name, this.price});

  factory DeliveryMethod.fromJson(Map<String, dynamic> json) {
    return DeliveryMethod(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        price: json["price"]);
  }
}
