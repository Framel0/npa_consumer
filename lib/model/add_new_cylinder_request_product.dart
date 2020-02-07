class AddNewCylinderRequestProduct {
  int productId;
  int quantity;

  AddNewCylinderRequestProduct({this.productId, this.quantity});

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
      };
}
