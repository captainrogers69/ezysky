import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '/components/dialogs/k_dialog.dart';
import '/services/dialog_service.dart';
import '/services/routing_service.dart';
import '/utils/helpers/permission_helper.dart';

final locationHelperProvider = Provider<LocationHelper>((ref) {
  return LocationHelper(ref);
});

class LocationHelper {
  final Ref _ref;
  LocationHelper(this._ref);

  Future<Placemark?> getAddressFromCoordinates(
      {required double? latitude, required double? longitude}) async {
    if (latitude == null ||
        longitude == null ||
        latitude == 0 ||
        longitude == 0) {
      return null;
    }
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        return placemarks.firstOrNull;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Position?> initLocation() async {
    bool gotPermission = await PermissionsHelper.getPermission(
      permissions: Permission.location,
      showSettingsDialog: () async {
        _ref.read(dialogServiceProvider).openDialog(
              dialog: KAlertDialog(
                onAction: () {
                  _ref.read(routingService).pop();
                  openAppSettings();
                },
                actiontitle: "Settings",
                subtitle:
                    "We need location permission to find properties nearby, Please click yes to allow",
                onCancel: () {
                  _ref.read(routingService).pop();
                },
                canceltitle: "Cancel",
                title: "Location Denied",
              ),
            );
        return false;
      },
    );
    log("$gotPermission", name: "locationServiceProvider - init");
    if (gotPermission) {
      Position? posd = await getLocation();
      return posd;
    } else {
      return null;
    }
  }

  Future<Position?> getLocation() async {
    try {
      // Use Geolocator to get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (e) {
      _ref.read(dialogServiceProvider).openDialog(
            dialog: KAlertDialog(
              onCancel: () {},
              title: "Location Error",
              subtitle: "Could not get your location. Please try again.",
              actiontitle: "Okay",
              onAction: () {
                _ref.read(routingService).pop();
              },
            ),
          );
      return null;
    }
  }

  /// Ask permission and get the current city name
  static Future<String?> getCity() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request.');
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Reverse geocoding to get city
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      return placemarks.first.locality; // 👈 This is the city
    }
    return null;
  }
}
