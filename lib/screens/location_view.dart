import 'package:bookoo2/shared/header.dart';
import 'package:bookoo2/utils/service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';

class LocationView extends StatefulWidget {
  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  GoogleMapController mapController;
  LatLng _center;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Set markerSet;
  String _countryCode;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  /// Open up google place search screen. The `_countryCode` is used to query google places.
  /// 
  /// Get `lat` and `lng` from the places search.
  /// Move camera and set markers when there is a result.
  /// 
  void getPlace() async {
    var location =
        await GooglePlaceService.instance.showGooglePlaceSearch(
      context,
      country: _countryCode,
    );

    if (location != null && location['lat'] != null && location['lng'] != null) {
      var latLng = LatLng(location['lat'], location['lng']);
      _setMarker(latLng);

      setState(() => _center = latLng);

      CameraUpdate cameraUpdate = CameraUpdate.newLatLng(latLng);
      mapController.moveCamera(cameraUpdate);
    }
  }

  /// Get current location with `location` plugin.
  /// 
  /// This will request permission in android when it's not granted.
  /// When permission is granted, it will get current location by calling `getLocation`,
  /// and set markers when result is achieved.
  /// 
  /// It also fetches current `countryCode` to be used when searching google places.
  /// 
  void getCurrentLocation() async {
    var currentLocation;
    var error;

    var location = new Location();

    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } 
      currentLocation = null;
    }

    if (error == null) {
      var latLng = LatLng(currentLocation.latitude, currentLocation.longitude);
      _setMarker(latLng);

      var addresses = await Geocoder.local.findAddressesFromCoordinates(
                  Coordinates(currentLocation.latitude, currentLocation.longitude));
      Map<String, dynamic> result = Map();
      result['address'] = addresses.first;
      _countryCode = addresses.first.countryCode;

      setState(() => _center = latLng);
      return;
    }
    setState(() => _center = LatLng(0,0));
  }

  void _setMarker(LatLng latLng) {
      MarkerId markerId = MarkerId('myMarker');
      // creating a new MARKER
      final Marker marker = Marker(
        markerId: markerId,
        position: latLng,
      );

      markers[markerId] = marker;
      setState(() {
        markerSet = Set<Marker>.of(markers.values);
      });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    getCurrentLocation();
  }

  void _onCameraMoved(CameraPosition pos) {
    _setMarker(pos.target);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderHeaderClose(
        context: context,
        title: Text('Map'),
        brightness: Theme.of(context).brightness,
        actions: [
          /// The button that calls `getPlace` method when pressed.
          Container(
            width: 56.0,
            child: RawMaterialButton(
              padding: EdgeInsets.all(0.0),
              shape: CircleBorder(),
              onPressed: () => getPlace(),
              child: Icon(
                Icons.search,
                color: Theme.of(context).textTheme.title.color,
              ),
            ),
          ),
          /// The button that `findAddressesFromCoordinates` when pressed.
          /// 
          /// returns `address` and `latlng` and pop current [Screen].
          Container(
            width: 56.0,
            child: RawMaterialButton(
              padding: EdgeInsets.all(0.0),
              shape: CircleBorder(),
              onPressed: () async {
                var addresses = await Geocoder.local.findAddressesFromCoordinates(
                  Coordinates(_center.latitude, _center.longitude));
                Map<String, dynamic> result = Map();
                result['address'] = addresses.first;
                result['latlng'] = _center;
                Navigator.pop(context, result);
              },
              child: Icon(
                Icons.check,
                color: Theme.of(context).textTheme.title.color,
              ),
            ),
          ),
        ],
      ),
      body: _center == null
        ? Container()
        : GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
          markers: markerSet ?? null,
          onCameraMove: _onCameraMoved,
        ),
    );
  }
}