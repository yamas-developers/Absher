import 'dart:convert';
import 'dart:developer';

// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:location/location.dart';
// import 'package:location/location.dart' as mLocation;
// import 'package:permission_handler/permission_handler.dart';

import '../../config/mj_config.dart';
import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';

class LocationProvider extends ChangeNotifier {
  LocationProvider() {

    // if(!flag)getCurrentLocation();
  }
  bool _error = false;
  String _message = '';
  bool _isLoading = false;
  LatLng? _currentLocation;
  Map? _selectedLocation;
  bool _isListLoading = false;
  String? _address;
  String? _city;

  List _addressDetails = [];

  String get message => _message;

  String? get city => _city;

  bool get isLoading => _isLoading;

  LatLng get currentLocation => _currentLocation!;

  Map get selectedLocation => _selectedLocation!;

  List get addressDetails => _addressDetails;

  bool get error => _error;

  String? get address => _address;

  set addressDetails( value) {
    _addressDetails = value;
  }

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

  set selectedLocation(Map value) {
    _selectedLocation = value;
    notifyListeners();
  }

  setCurrentLocation(location, {bool shouldSave = false}) async {
    _currentLocation = LatLng(location.latitude, location.longitude);
    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);
    String addr =
        "${placemarks.reversed.last.subLocality} ${placemarks.reversed.last.subAdministrativeArea} ${placemarks.reversed.last.administrativeArea}";
    if (checkIfLocaationExist(addr)) {
      showToast("Address already in the list");
      return;
    }
    _address = addr;
    _city = placemarks.reversed.last.subAdministrativeArea;
    if (shouldSave) {
      Map<String, dynamic> data = {
        "address": _address,
        "city": _city,
        "lat": location.latitude,
        "lng": location.longitude,
      };
      _addressDetails.insert(0, data);
      if (_addressDetails.length > 3)
        _addressDetails.removeRange(2, _addressDetails.length - 1);
      _selectedLocation = data;
      log('addr: ${_addressDetails.length}');
    }
    notifyListeners();
    if (shouldSave) setAddresses();
  }

  checkIfLocaationExist(address) {
    bool isExist = false;
    _addressDetails.forEach((element) {
      if (element["address"] == address) isExist = true;
    });
    return isExist;
  }

  setCurrentAddress(Map data) {
    if (data == null) return null;
    _address = data["address"] ?? "N/A";
    _city = data["city"] ?? "N/A";
    if (data["lat"] != null && data["lng"] != null)
      _currentLocation = LatLng(data["lat"], data["lng"]);
    _selectedLocation = data;
    notifyListeners();
    setAddresses();
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

  Future<Map?> getLocation(String placeId) async {
    final String request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$GOOGLE_API_KEY';

    final response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        return {
          "id": placeId,
          'address': result['result']['formatted_address'],
          'lat': result['result']['geometry']['location']['lat'].toString(),
          'lng': result['result']['geometry']['location']['lng'].toString()
        };
      }
      //return null;
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  setAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(MJConfig.mj_addresses, json.encode(_addressDetails));
    await prefs.setString(MJConfig.mj_current_address,
        json.encode(_selectedLocation));
  }

  getAddresses() async {
    bool flag = false;
    final prefs = await SharedPreferences.getInstance();
    dynamic jsonData = await prefs.getString(MJConfig.mj_addresses);
    dynamic jsonLocData = await prefs.getString(MJConfig.mj_current_address);
    if(jsonData== null)_addressDetails = [];
    List details = json.decode(jsonData);
    _addressDetails = details;
    if(jsonLocData!=null){
      Map datum = json.decode(jsonLocData);
      log("MJ: selected location: ${datum}");
      _selectedLocation = datum;
      setCurrentAddress(datum);
      flag = true;
    }
    notifyListeners();
    return flag;
  }
}
