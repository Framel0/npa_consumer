class Product {
  int id;
  String name;
  double price;
  int quantity;

  Product.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    price = json["price"];
    quantity = 0;
  }
}
