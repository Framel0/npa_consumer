class RequestProduct {
  final String size;
  final int quantity;

  RequestProduct({this.size, this.quantity});

  factory RequestProduct.fromJson(Map<String, dynamic> json) {
    return RequestProduct(
      size: json["size"],
      quantity: json["quantity"],
    );
  }
}
