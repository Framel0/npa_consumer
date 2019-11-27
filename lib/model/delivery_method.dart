class DeliveryMethod {
  int id;
  String code;
  String name;

  DeliveryMethod({this.id, this.code, this.name});

  DeliveryMethod.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    code = json["code"];
    name = json["name"];
  }

  static List<DeliveryMethod> getDeliveryMethods() {
    return <DeliveryMethod>[
      DeliveryMethod(id: 1, code: "", name: "Home"),
      DeliveryMethod(id: 2, code: "", name: "Pick Up")
    ];
  }
}
