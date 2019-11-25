class CylinderSize {
  int id;
  String size;

  CylinderSize.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.size = json["size"];
  }
}
