import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class Geolocation extends StatefulWidget {
  final bool androidFusedLocation;

  const Geolocation({Key key, this.androidFusedLocation}) : super(key: key);
  @override
  _GeolocationState createState() => _GeolocationState();
}

class _GeolocationState extends State<Geolocation> {
  Position _lastKnownPosition;
  Position _currentPosition;
  Placemark _position;
  Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;

  final Geolocator _geolocator = Geolocator();
  String _name = '';
  String _isoCountryCode = '';
  String _country = '';
  String _postalCode = '';
  String _administrativeArea = '';
  String _subAdministrativeArea = '';
  String _locality = '';
  String _subLocality = '';
  String _thoroughfare = '';
  String _subThoroughfare = '';
  String _latitude = '';
  String _longitude = '';

  @override
  void initState() {
    super.initState();

    _initLastKnownLocation();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {
      _lastKnownPosition = null;
      _currentPosition = null;
    });

    _initLastKnownLocation();
    // _initCurrentLocation();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initLastKnownLocation() async {
    Position position;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final Geolocator geolocator = Geolocator()
        ..forceAndroidLocationManager = !widget.androidFusedLocation;
      position = await geolocator.getLastKnownPosition(
          desiredAccuracy: LocationAccuracy.best);
    } on PlatformException {
      position = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      _lastKnownPosition = position;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<Position> _initCurrentLocation() async {
    Position pos = await _geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    return pos;
  }

  Future<void> _onLookupAddressPressed({@required Position position}) async {
    final List<Placemark> placemarks = await _geolocator
        .placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks != null && placemarks.isNotEmpty) {
      _position = placemarks[0];
      setState(() {
        _name = _position.name;
        _isoCountryCode = _position.isoCountryCode;
        _country = _position.country;
        _postalCode = _position.postalCode;
        _administrativeArea = _position.administrativeArea;
        _subAdministrativeArea = _position.subAdministrativeArea;
        _locality = _position.locality;
        _subLocality = _position.subLocality;
        _thoroughfare = _position.thoroughfare;
        _subThoroughfare = _position.subThoroughfare;
        _latitude = _position.position.latitude.toString();
        _longitude = _position.position.longitude.toString();
        // _position.position.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GeolocationStatus>(
      future: geolocator.checkGeolocationPermissionStatus(),
      builder:
          (BuildContext context, AsyncSnapshot<GeolocationStatus> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data == GeolocationStatus.denied) {
          return Column(
            children: <Widget>[
              Text("data", style: Theme.of(context).textTheme.title),
              Text("data", style: Theme.of(context).textTheme.subtitle),
            ],
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("Location"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(0.0),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // _placeholder(title: "Name:", subtitle: _name),
                      // _placeholder(
                      //     title: "Country Code:", subtitle: _isoCountryCode),
                      // _placeholder(title: "Country:", subtitle: _country),
                      // _placeholder(
                      //     title: "Postal Code:", subtitle: _postalCode),
                      _placeholder(
                          title: "Administrative Area:",
                          subtitle: _administrativeArea),
                      _placeholder(
                          title: "Sub Administrative Area:",
                          subtitle: _subAdministrativeArea),
                      _placeholder(title: "Locality:", subtitle: _locality),
                      _placeholder(
                          title: "Sub Locality:", subtitle: _subLocality),
                      _placeholder(
                          title: "Thoroughfare:", subtitle: _thoroughfare),
                      _placeholder(
                          title: "Sub Thoroughfare:",
                          subtitle: _subThoroughfare),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                    ),
                    child: const Text(
                      'Get Current Location',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () async {
                      final Position pos = await _initCurrentLocation();
                      _onLookupAddressPressed(position: pos);

                      // await AddressProvider.dbProvider.updateAddress(address);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _placeholder({@required String title, String subtitle = ""}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(title, style: Theme.of(context).textTheme.headline),
        ),
        Text(subtitle, style: Theme.of(context).textTheme.subhead),
      ],
    );
  }

  String _fusedLocationNote() {
    if (widget.androidFusedLocation) {
      return 'Geolocator is using the Android FusedLocationProvider. This requires Google Play Services to be installed on the target device.';
    }

    return 'Geolocator is using the raw location manager classes shipped with the operating system.';
  }
}
