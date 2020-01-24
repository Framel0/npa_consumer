import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class GoogleMapServiceApiClient {
  static const apiKey = "";
  final http.Client httpClient;

  GoogleMapServiceApiClient({@required this.httpClient})
      : assert(httpClient != null);

  Future<String> fetchRouteCoordinates(
      {@required LatLng origin, @required LatLng destination}) async {
    final googleMapurl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey";
    final googleMapResponse = await httpClient.get(googleMapurl);

    if (googleMapResponse.statusCode != 200) {
      print(googleMapResponse.statusCode);
      throw Exception('error getting districts');
    }

    Map values = jsonDecode(googleMapResponse.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }
}
