import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as manager;
import 'package:wecount/utils/logger.dart';

class LocationService {
  Future<LatLng?> getUserLocation() async {
    manager.LocationData? currentLocation;
    final location = manager.Location();
    try {
      currentLocation = await location.getLocation();
      final lat = currentLocation.latitude!;
      final lng = currentLocation.longitude!;
      final center = LatLng(lat, lng);
      return center;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }
}

class GooglePlaceService {
  static final GooglePlaceService _instance = GooglePlaceService();
  static GooglePlaceService get instance => _instance;

  Future<Map<String, dynamic>> showGooglePlaceSearch(
    BuildContext context, {
    String country = 'us',
  }) async {
    Map<String, dynamic> location = {};

    final homeScaffoldKey = GlobalKey<ScaffoldState>();

    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: FlutterConfig.get('PLACE_API_KEY'),
      language: Intl.getCurrentLocale(),
      mode: Mode.fullscreen,
      onError: (e) {
        logger.e(e.errorMessage);
      },
      types: [],
      strictbounds: false,
      components: [Component(Component.country, country)],
    );
    await _displayPrediction(p, homeScaffoldKey.currentState, (lat, lng) {
      location['lat'] = lat;
      location['lng'] = lng;
    });

    /// Get city from p string
    if (p != null) {
      List<String> list = p.description!.split(', ');
      if (list.length > 1) {
        location['country'] = list[list.length - 1];

        /// country
        location['city'] = list[list.length - 2];

        /// city
      }

      if (location['lat'] == null) {
        final query = list.toString();
        try {
          var addresses = await locationFromAddress(query);
          var first = addresses.first;
          location['lat'] = first.latitude;
          location['lng'] = first.longitude;
        } catch (err) {
          logger.d('catch: ${err.toString()}');
        }
      }
    }
    return location;
  }

  Future<void> _displayPrediction(Prediction? p, ScaffoldState? scaffold,
      Function(double, double) callback) async {
    // GoogleMapsPlaces _places = GoogleMapsPlaces();

    // if (p != null) {
    //   // get detail (lat/lng)
    //   PlacesDetailsResponse detail =
    //       await _places.getDetailsByPlaceId(p.placeId!);
    //   if (detail.result != null) {
    //     callback(detail.result.geometry!.location.lat,
    //         detail.result.geometry!.location.lng);
    //   }
    // }
  }
}
