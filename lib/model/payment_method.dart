class PaymentMethod {
  final int id;
  final String code;
  final String name;

  PaymentMethod({this.id, this.code, this.name});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
        id: json["id"], code: json["code"], name: json["name"]);
  }
}
