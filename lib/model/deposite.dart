class Deposite {
  int id;
  String name;

  Deposite.fromJson(Map<String, dynamic> json){
    id = json["id"];
    id = json["name"];
  }
}
