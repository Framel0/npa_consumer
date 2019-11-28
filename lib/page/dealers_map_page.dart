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
    zoom: 14.4746,
  );

  final Geolocator _geolocator = Geolocator();

  Position _currentPosition;

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<DealerBloc>(context)..dispatch(FetchDealers());
    BlocProvider.of<DealerBloc>(context)
      ..dispatch(FetchDealers(id: widget.lpgmc.id));

    // BlocBuilder<DealerBloc, DealerState>(builder: (context, state) {
    //   if (state is DealerLoaded) {
    //     Future.delayed(Duration(seconds: 3));
    // _getCurrentLocation();
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // String _info;
  // final _markers = [
  //   MapInfo(id: "1", lat: 5.63927, long: -0.19528, info: "Dealer1"),
  //   MapInfo(id: "2", lat: 5.6050, long: -0.1433, info: "Dealer2"),
  //   MapInfo(id: "3", lat: 5.5594, long: -0.1970, info: "Dealer3"),
  //   MapInfo(id: "4", lat: 5.5924, long: -0.2163, info: "Dealer4"),
  //   MapInfo(id: "5", lat: 5.5813, long: -0.1670, info: "Dealer5"),
  //   MapInfo(id: "6", lat: 5.5907, long: -0.5907, info: "Dealer6"),
  //   MapInfo(id: "7", lat: 5.63927, long: -0.19528, info: "Dealer7"),
  //   MapInfo(id: '8', lat: 5.5943, long: -0.1851, info: "Dealer8"),
  //   MapInfo(id: "9", lat: 5.6210, long: -0.1825, info: "Dealer9"),
  //   MapInfo(id: "10", lat: 5.5818, long: -0.2219, info: "Dealer10"),
  //   MapInfo(id: "11", lat: 5.5797, long: -0.1652, info: "Dealer11"),
  //   MapInfo(id: "12", lat: 5.5883, long: -0.1450, info: "Dealer12"),
  //   MapInfo(id: "13", lat: 5.5892, long: -0.1655, info: "Dealer13"),
  //   MapInfo(id: "14", lat: 5.5991, long: -0.2153, info: "Dealer15"),
  //   MapInfo(id: "15", lat: 5.5767, long: -0.1558, info: "Dealer16"),
  //   MapInfo(id: "16", lat: 5.6374, long: -0.1713, info: "Dealer17"),
  //   MapInfo(id: "17", lat: 5.6261, long: -0.1894, info: "Dealer18"),
  //   MapInfo(id: "18", lat: 5.6051, long: -0.1685, info: "Dealer19"),
  //   MapInfo(id: "19", lat: 5.6123, long: -0.2118, info: "Dealer20"),
  //   MapInfo(id: "20", lat: 5.6010, long: -0.1690, info: "Dealer21"),
  // ];

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
          zoom: 15)));
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
