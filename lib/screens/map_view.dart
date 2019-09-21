import 'package:bookoo2/shared/header.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController mapController;
  LatLng _center;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Set markerSet;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
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
      ),
      body: GoogleMap(
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