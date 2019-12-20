import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:npa_user/bloc/dealer/dealer.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widgets.dart';

class DealersMapPage extends StatefulWidget {
  final Lpgmc lpgmc;

  const DealersMapPage({Key key, @required this.lpgmc}) : super(key: key);
  @override
  _DealersMapPageState createState() => _DealersMapPageState();
}

class _DealersMapPageState extends State<DealersMapPage> {
  Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController mapController;

  static CameraPosition _initPos = CameraPosition(
    target: LatLng(5.601452, -0.184879),
    zoom: 9,
  );

  final Geolocator _geolocator = Geolocator();

  Position _currentPosition;

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<DealerBloc>(context)..dispatch(FetchDealers());
    if (widget.lpgmc.id != null) {
      BlocProvider.of<DealerBloc>(context)
        ..dispatch(FetchDealers(id: widget.lpgmc.id));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<DealerBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose Dealer",
        ),
      ),
      body: BlocBuilder<DealerBloc, DealerState>(builder: (context, state) {
        if (state is DealerLoading) {
          return LoadingIndicator();
        }

        if (state is DealerLoaded) {
          final dealers = state.dealers;
          return Container(
            child: Stack(
              children: <Widget>[
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _initPos,
                  onMapCreated: (GoogleMapController controller) {
                    _mapController.complete(controller);
                    mapController = controller;
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: dealers
                      .map((d) => _registerMarker(
                          onTap: () async {
                            _showBottomSheet(buildContext: context, dealer: d);
                          },
                          markerId: d.id.toString(),
                          lat: d.latitude,
                          lng: d.longitude,
                          name: d.firstName + " " + d.lastName,
                          address: d.address))
                      .toSet(),
                ),
                Positioned(
                  bottom: 50,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: OutlineButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      ),
                      borderSide:
                          BorderSide(color: colorAccentYellow, width: 2),
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      child: Text(
                        "Current Position",
                        style: TextStyle(
                            color: colorPrimary,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _getCurrentLocation();
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is DealerError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Error",
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.red),
              ),
              IconButton(
                icon: Icon(Icons.replay),
                onPressed: () {
                  bloc.dispatch(FetchDealers(id: widget.lpgmc.id));
                },
              )
            ],
          );
        }
      }),
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
          zoom: 11)));
    });
  }

  void _showBottomSheet({BuildContext buildContext, Dealer dealer}) {
    showModalBottomSheet(
        context: buildContext,
        builder: (buildContext) {
          return Container(
            color: Color(0XFF737373),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    topRight: const Radius.circular(10),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.05), BlendMode.dstATop),
                        image: AssetImage('assets/images/npa_logo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(dealer.firstName + " " + dealer.lastName,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(dealer.address,
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Text(dealer.phoneNumber,
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: RaisedButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0.0)),
                          side: BorderSide(color: Colors.white)),
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      // color: Theme.of(context).buttonColor,
                      textColor: Colors.white,
                      child: Text(
                        'Select',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context, dealer);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Marker _registerMarker(
      {GestureTapCallback onTap,
      @required String markerId,
      @required double lat,
      @required double lng,
      String name,
      String address}) {
    return Marker(
        onTap: onTap,
        markerId: MarkerId(markerId),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: name, snippet: address),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
  }
}

class MapInfo {
  final String id;
  final double lat;
  final double long;
  final String info;

  MapInfo({this.id, this.lat, this.long, this.info});

  @override
  String toString() {
    return " $id, $lat, $long, $info";
  }
}
