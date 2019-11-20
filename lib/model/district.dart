class District {
  int id;
  String code;
  String name;
  int regionId;

  District({this.id, this.code, this.name, this.regionId});

  District.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    code = json["code"];
    name = json["name"];
    regionId = json["regionId"];
  }
}
