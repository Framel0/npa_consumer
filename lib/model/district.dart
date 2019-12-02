class District {
  final int id;
  final String code;
  final String name;
  final int regionId;

  District({this.id, this.code, this.name, this.regionId});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        regionId: json["regionId"]);
  }
}
