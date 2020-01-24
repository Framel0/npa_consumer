import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:npa_user/bloc/google_map_service/google_map_service.dart';
import 'package:npa_user/repositories/google_map_service/google_map_service.dart';
import 'package:npa_user/widget/loading_indicator.dart';

class RequestTrackingMapPage extends StatefulWidget {
  @override
  _RequestTrackingMapPageState createState() => _RequestTrackingMapPageState();
}

class _RequestTrackingMapPageState extends State<RequestTrackingMapPage> {
  GoogleMapController mapController;

  static LatLng _initPos;
  LatLng _lastPosition = _initPos;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _initPos == null
            ? Center(
                child: LoadingIndicator(),
              )
            : BlocBuilder<GoogleMapServiceBloc, GoogleMapServiceState>(
                builder: (context, state) {
                if (state is GoogleMapServiceLoading) {
                  return Center(
                    child: LoadingIndicator(),
                  );
                }
                if (state is GoogleMapServiceLoaded) {
                  final line = state.polylines;

                  createRoute(line);
                  return Stack(
                    children: <Widget>[
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _initPos,
                          zoom: 12,
                        ),
                        onMapCreated: onCreated,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        compassEnabled: true,
                        mapType: MapType.normal,
                        polylines: _polylines,
                      ),
                    ],
                  );
                }
                if (state is GoogleMapServiceError) {
                  return Center(
                    child: LoadingIndicator(),
                  );
                }
              }));
  }

  // ! TO CREATE ROUTE
  void createRoute(List<LatLng> polylines) {
    _polylines.add(Polyline(
        polylineId: PolylineId(_lastPosition.toString()),
        width: 10,
        points: polylines,
        color: Colors.black));
  }

  // ! ADD A MARKER ON THE MAO
  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId(_lastPosition.toString()),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "go here"),
        icon: BitmapDescriptor.defaultMarker));
    // notifyListeners();
  }

  onCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  onCameraMove(CameraPosition position) {}

  void _getUserLocation() async {
    Position pos = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initPos = LatLng(pos.latitude, pos.longitude);
    });
  }
}
