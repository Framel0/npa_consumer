class Region {
  int id;
  String code;
  String name;

  Region({this.id, this.code, this.name});

  Region.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    code = json["code"];
    name = json["name"];
  }
}
