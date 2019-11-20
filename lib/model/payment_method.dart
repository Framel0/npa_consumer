class PaymentMethod {
  final int id;
  final String code;
  final String name;

  PaymentMethod({this.id, this.code, this.name});

  static List<PaymentMethod> getPaymentMethods() {
    return <PaymentMethod>[
      PaymentMethod(id: 1, code: "", name: "Cash"),
      PaymentMethod(id: 2, code: "", name: "Mobile Money"),
    ];
  }
}
