class ConsumerProduct {
  final int id;
  final String name;
  final double price;
  final int quantity;
  int selectedQuantity;

  ConsumerProduct(
      {this.id, this.name, this.price, this.quantity, this.selectedQuantity});

  factory ConsumerProduct.fromJson(Map<String, dynamic> json) {
    return ConsumerProduct(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      quantity: json["quantity"],
      selectedQuantity: 0,
    );
  }
}
