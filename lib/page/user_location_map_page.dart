import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserLocationMapPage extends StatefulWidget {
  static CameraPosition _initPos = CameraPosition(
    target: LatLng(5.601452, -0.184879),
    zoom: 14.4746,
  );

  @override
  _UserLocationMapPageState createState() => _UserLocationMapPageState();
}

class _UserLocationMapPageState extends State<UserLocationMapPage> {
  Completer<GoogleMapController> _mapController = Completer();

  GoogleMapController mapController;

  final Geolocator _geolocator = Geolocator();

  Position _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: UserLocationMapPage._initPos,
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
                mapController = controller;
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
            Positioned(
              bottom: 50,
              child: RaisedButton(
                child: null,
                onPressed: () {
                  _getCurrentLocation();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Position> _initCurrentLocation() async {
    Position pos = await _geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    return pos;
  }

  _getCurrentLocation() async {
    _currentPosition = await _initCurrentLocation();
    mapController = await _mapController.future;
    setState(() {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
          zoom: 15)));
    });
  }
}
