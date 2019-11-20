class Region {
  int id;
  String code;
  String name;

  Region({this.id, this.code, this.name});

  Region.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    id = json["code"];
    id = json["name"];
  }
}
