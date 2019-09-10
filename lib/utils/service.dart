import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:google_maps_webservice/places.dart';


class LocationService {
   Future<LatLng> getUserLocation() async {
    LocationManager.LocationData currentLocation;
    final location = LocationManager.Location();
    try {
      currentLocation = await location.getLocation();
      final lat = currentLocation.latitude;
      final lng = currentLocation.longitude;
      final center = LatLng(lat, lng);
      return center;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }
}

class GooglePlaceService {
  static GooglePlaceService _instance = GooglePlaceService();
  static GooglePlaceService get instance => _instance;

  String kGoogleApiKey = '[KEY_GOOGLE_PLACE_API]';

  Future<Map<String, dynamic>> showGooglePlaceSearch(BuildContext context, {
    String locale = 'en',
    String country = 'us',
  }) async {
    Map<String, dynamic> location = Map();

    final homeScaffoldKey = new GlobalKey<ScaffoldState>();

    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      mode: Mode.fullscreen,
      language: locale,
      components: [new Component(Component.country, "fr")],
    );
    await _displayPrediction(p, homeScaffoldKey.currentState, (lat, lng, address) {
      location['lat'] = lat;
      location['lng'] = lng;
      location['address'] = address;
    });
    /// Get city from p string
    if (p != null) {
      List<String> list = p.description.split(', ');
      if (list.length > 1) {
        location['country'] = list[list.length - 1]; /// country
        location['city'] = list[list.length - 2]; /// city
      }
    }
    return location;
  }

  Future<Null> _displayPrediction(Prediction p, ScaffoldState scaffold, Function(double, double, String) callback) async {
    GoogleMapsPlaces _places = new GoogleMapsPlaces();
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
      callback(detail.result.geometry.location.lat, detail.result.geometry.location.lng, p.description);
    }
  }
}
