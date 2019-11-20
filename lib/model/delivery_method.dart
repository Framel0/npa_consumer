class DeliveryMethod {
  final int id;
  final String code;
  final String name;

  DeliveryMethod({this.id, this.code, this.name});

  static List<DeliveryMethod> getDeliveryMethods() {
    return <DeliveryMethod>[
      DeliveryMethod(id: 1, code: "", name: "Home"),
      DeliveryMethod(id: 2, code: "", name: "Pick Up")
    ];
  }
}
