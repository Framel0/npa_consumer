class RefillRequestProduct {
  int productId;
  int quantity;

  RefillRequestProduct({this.productId, this.quantity});
  

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
      };

}
