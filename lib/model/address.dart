import 'package:npa_user/model/models.dart';

class Address {
  int id;
  Region region;
  District district;
  String residential;
  String gps;

  Address({this.id, this.region, this.district, this.residential, this.gps});

  Address.fromJson(Map<String, dynamic> json) {}
}
