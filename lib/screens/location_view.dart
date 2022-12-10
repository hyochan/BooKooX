import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geocoding/geocoding.dart' show placemarkFromCoordinates;
import 'package:wecount/widgets/common/loading_indicator.dart';
import 'package:wecount/widgets/header.dart';
import 'package:wecount/utils/service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationView extends HookWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late GoogleMapController mapController;
    var center = useState<LatLng?>(null);
    var markerSet = useState<Set<Marker>>({});
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
    late String countryCode;

    void setMarker(LatLng latLng) {
      MarkerId markerId = const MarkerId('myMarker');

      // creating a new MARKER
      final Marker marker = Marker(
        markerId: markerId,
        position: latLng,
      );

      markers[markerId] = marker;

      markerSet.value = Set<Marker>.of(markers.values);
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
      LocationData? currentLocation;

      var location = Location();

      try {
        currentLocation = await location.getLocation();
      } catch (e) {
        // if (e.currency == 'PERMISSION_DENIED') {
        //   error = 'Permission denied';
        // }
        currentLocation = null;
      }

      final LatLng latLng =
          LatLng(currentLocation!.latitude!, currentLocation.longitude!);
      setMarker(latLng);

      center.value = latLng;
      return;
    }

    useEffect(() {
      countryCode = WidgetsBinding.instance.window.locale.countryCode!;
      getCurrentLocation();
      return null;
    }, []);

    /// Open up google place search screen. The `_countryCode` is used to query google places.
    ///
    /// Get `lat` and `lng` from the places search.
    /// Move camera and set markers when there is a result.
    ///
    void getPlace() async {
      var location = await GooglePlaceService.instance.showGooglePlaceSearch(
        context,
        country: countryCode,
      );

      if (location['lat'] != null && location['lng'] != null) {
        var latLng = LatLng(location['lat'], location['lng']);
        setMarker(latLng);

        center.value = latLng;

        CameraUpdate cameraUpdate = CameraUpdate.newLatLng(latLng);
        mapController.moveCamera(cameraUpdate);
      }
    }

    void onCreateMap(GoogleMapController controller) {
      mapController = controller;
    }

    void onCameraMove(CameraPosition pos) => setMarker(pos.target);

    return center.value == null
        ? const LoadingIndicator()
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: renderHeaderClose(
              context: context,
              brightness: Theme.of(context).brightness,
              actions: [
                /// The button that calls `getPlace` method when pressed.
                SizedBox(
                  width: 56.0,
                  child: RawMaterialButton(
                    padding: const EdgeInsets.all(0.0),
                    shape: const CircleBorder(),
                    onPressed: () => getPlace(),
                    child: Icon(
                      Icons.search,
                      color: Theme.of(context).textTheme.displayLarge!.color,
                    ),
                  ),
                ),

                /// The button that `findAddressesFromCoordinates` when pressed.
                ///
                /// returns `address` and `latlng` and pop current [Screen].
                SizedBox(
                  width: 56.0,
                  child: RawMaterialButton(
                    padding: const EdgeInsets.all(20.0),
                    shape: const CircleBorder(),
                    onPressed: () async {
                      var addresses = await placemarkFromCoordinates(
                        center.value!.latitude,
                        center.value!.longitude,
                      );
                      Map<String, dynamic> result = {};
                      result['address'] = addresses.first.street;
                      result['latlng'] = center;

                      if (context.mounted) {
                        Navigator.pop(context, result);
                      }
                    },
                    child: Icon(
                      Icons.check,
                      color: Theme.of(context).textTheme.displayLarge!.color,
                    ),
                  ),
                ),
              ],
            ),
            body: GoogleMap(
              onMapCreated: onCreateMap,
              initialCameraPosition: CameraPosition(
                target: center.value!,
                zoom: 11.0,
              ),
              markers: markerSet.value,
              onCameraMove: onCameraMove,
            ),
          );
  }
}
