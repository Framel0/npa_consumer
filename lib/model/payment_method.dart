class PaymentMethod {
  int id;
  String code;
  String name;

  PaymentMethod({this.id, this.code, this.name});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    code = json["code"];
    name = json["name"];
  }

  static List<PaymentMethod> getPaymentMethods() {
    return <PaymentMethod>[
      PaymentMethod(id: 1, code: "", name: "Cash"),
      PaymentMethod(id: 2, code: "", name: "Mobile Money"),
    ];
  }
}
