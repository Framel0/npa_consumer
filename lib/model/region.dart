class Region {
  final int id;
  final String code;
  final String name;

  Region({this.id, this.code, this.name});

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(id: json["id"], code: json["code"], name: json["name"]);
  }
}
