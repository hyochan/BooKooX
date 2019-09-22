import 'package:bookoo2/shared/header.dart';
import 'package:bookoo2/utils/general.dart';
import 'package:bookoo2/utils/localization.dart';
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

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  /// [Not used] Open up google place search screen.
  /// 
  /// This isn't used currently but willing to provide in next releases.
  /// Since we need to convert address to `lat` and `lng`,
  /// but it does not seem to have the current feature.
  /// 
  void getPlace() async {
    var location =
        await GooglePlaceService.instance.showGooglePlaceSearch(
      context,
      locale: Localization.of(context).locale.languageCode,
    );

    print('location: $location');
  }

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
          /// Currently unused but willing to provide in the future.
          // Container(
          //   width: 56.0,
          //   child: RawMaterialButton(
          //     padding: EdgeInsets.all(0.0),
          //     shape: CircleBorder(),
          //     onPressed: () => getPlace(),
          //     child: Icon(
          //       Icons.search,
          //       color: Theme.of(context).textTheme.title.color,
          //     ),
          //   ),
          // ),
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