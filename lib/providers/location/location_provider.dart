import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:location/location.dart';
// import 'package:location/location.dart' as mLocation;
// import 'package:permission_handler/permission_handler.dart';

import '../../helpers/public_methods.dart';

class LocationProvider extends ChangeNotifier {
  bool _error = false;
  String _message = '';
  bool _isLoading = false;
  LatLng? _currentLocation;
  bool _isListLoading = false;
  String? _address;
  String? _city;

  String get message => _message;
  String? get city => _city;


  bool get isLoading => _isLoading;

  LatLng get currentLocation => _currentLocation!;

  bool get error => _error;

  String? get address => _address;

  set error(bool value) {
    _error = value;
  }

  set message(String value) {
    _message = value;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set currentLocation(LatLng value) {
    _currentLocation = value;
    notifyListeners();
  }

  setCurrentLocation(location) async {
    currentLocation = LatLng(location.latitude, location.longitude);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(currentLocation.latitude, currentLocation.longitude);
    String addr = "${placemarks.reversed.last.subLocality} ${placemarks.reversed.last.subAdministrativeArea}, ${placemarks.reversed.last.administrativeArea}";
    _address = addr;
    _city = placemarks.reversed.last.subAdministrativeArea;
    log('addr: ${addr}');
    notifyListeners();
  }

  getCurrentLocation() async {
    // return;
    message = "Getting Current Location";
    isLoading = true;
    Position location = (await getUserCurrentLocation());
    isLoading = false;
    print("================================");
    print(location);
    if (location != null) {
     await setCurrentLocation(location);
      // notifyListeners();
      error = false;
    } else {
      message = "Cannot get your location";
      error = true;
    }
    // -122.08402063697578 - 37.42295222869878
    // currentLocation = LatLng(37.42295222869878, -122.08402063697578);
    // getCurrentLocationStores();
  }

  onChangeLocation() async {
    // var location = mLocation.Location();
    // location.onLocationChanged.listen((event) {
    //   print(event);
    // });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      showToast(error.toString());
    });
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }


}
