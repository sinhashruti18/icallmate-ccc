
import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'dart:async';

import 'package:geolocator/geolocator.dart';

class GetLocation {
  static Position? _currentPosition;
  static String? location;
  static String? adminarea;

  static String? street;

  static String? sublocality;
  static String? locality;
  static String? country;
  static double? lat;
  static double? long;
  static double? previous_lat;
  static double? previous_long;
  static bool ischecked = false;
  static Position? currentPosition;

  static Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  static _getCurrentLocation(BuildContext context) async {
    final hasPermission = await _handleLocationPermission(context);

    if (!hasPermission) return;
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      _currentPosition = position;
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  static _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      lat = _currentPosition!.latitude;
      long = _currentPosition!.longitude;

      // previous_lat = lat;
      // previous_long = long;

      print("latitude=$lat");
      print("longitude=$long");

      Placemark place = placemarks[0];

      street = '${place.street},${place.name}';
      sublocality = '${place.subLocality},${place.subAdministrativeArea},';
      locality =
          '${place.locality},${place.administrativeArea}, ${place.postalCode}';
      country = '${place.country}';
    } catch (e) {
      print(e);
    }
  }
}
