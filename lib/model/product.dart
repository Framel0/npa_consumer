class Product {
  final int id;
  final String name;
  final double price;
  int quantity;

  Product({this.id, this.name, this.price, this.quantity});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["id"], name: json["name"], price: json["price"], quantity: 0);
  }
}
