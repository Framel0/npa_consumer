class Lpgmc {
  int id;
  String name;
  String address;
  String email;
  String phoneNumber;
  String city;

  Lpgmc.fromJson(Map <String, dynamic> json){
    id = json["id"];
    name = json["name"];
    address = json["address"];
    email = json["email"];
    phoneNumber = json["phoneNumber"];

  }
}
