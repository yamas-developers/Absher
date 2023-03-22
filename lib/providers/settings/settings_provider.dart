import 'dart:developer';

import 'package:absher/helpers/public_methods.dart';
import 'package:absher/helpers/session_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../helpers/constants.dart';
import '../../helpers/route_constants.dart';
import '../../models/banner.dart';
import '../../models/campaign.dart';
import '../../models/restaurant.dart';
import '../../models/zone.dart';

class SettingsProvider extends ChangeNotifier {
  List<Campaign>? _campaigns;
  List<Bannerr>? _banners;
  Zone? _zone;
  bool _loading = false;
  bool _operatingArea = false;
  bool _isConnected = false;
  bool _locationPermission = false;
  bool _isInitialized = false;

  /////////////////////////////////geters
  List<Campaign>? get campaigns => _campaigns;

  List<Bannerr>? get banners => _banners;

  Zone? get zone => _zone;

  bool get loading => _loading;

  bool get isInitialized => _isInitialized;

  bool get operatingArea => _operatingArea;

  bool get isConnected => _isConnected;

  bool get locationPermission => _locationPermission;

  ////////////////////////////////setters
  set operatingArea(bool operatingArea) {
    _operatingArea = operatingArea;
    notifyListeners();
  }

  set loading(bool load) {
    _loading = load;
    notifyListeners();
  }

  set isInitialized(bool val) {
    _isInitialized = val;
    notifyListeners();
  }

  set isConnected(bool isCon) {
    _isConnected = isCon;
    notifyListeners();
  }

  set locationPermission(bool perm) {
    _locationPermission = perm;
    notifyListeners();
  }

  setZone(dynamic data) {
    _zone = Zone.fromJson(data);
    notifyListeners();
  }

  setCompaigns(List<dynamic> data) {
    _campaigns = [];
    data.forEach((element) {
      _campaigns!.add(Campaign.fromJson(element));
    });
    // notifyListeners();
  }

  setBanner(List<dynamic> data) {
    _banners = [];
    data.forEach((element) {
      _banners!.add(Bannerr.fromJson(element));
    });
    // notifyListeners();
  }

  ////////////////////////////////////////////////////////////end setters

  requestPermissions({toast = false}) async {
    _locationPermission = await Permission.location.request().isGranted;
    // notifyListeners();
    /////multiple permissions can be requested here
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();

    logInfo(
        "location permission: ${statuses[Permission.location]}, ${statuses[Permission.location] == PermissionStatus.permanentlyDenied}");
    if (toast)
      showToast("Permission Permanently Denied: Try to Allow in app settings:");
    // _loading = false;
    notifyListeners();
  }

  verifyConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    _isConnected = (connectivityResult == ConnectivityResult.wifi) ||
        (connectivityResult == ConnectivityResult.mobile);
    if (!_isConnected) showToast("Internet not connected");
    notifyListeners();
  }

  getSettings(LatLng currentLocation) async {
    await verifyConnectivity();
    if (!_isConnected) {
      return;
    }

    // _loading = true;
    // notifyListeners();

    dynamic response = await MjApiService().getRequest(MJ_Apis.get_zone_id +
        "?lat=${currentLocation.latitude}&lng=${currentLocation.longitude}");
    log("response in provider: ${response}");
    if (response != null) {
      if (response["status_code"] == 0) {
        _operatingArea = false;
      } else {
        _operatingArea = true;
      }
      // log("MJ: operating area in provider: ${_operatingArea}, ${response["status_code"]}");
      setZone(response["response"]);
      if (_zone != null && _operatingArea) {
        await setZoneId(_zone!.zoneId);
        dynamic response1 = await MjApiService()
            .getRequest(MJ_Apis.banners, zoneId: _zone!.zoneId);
        if (response1 != null) {
          setCompaigns(response1["response"]["campaigns"]);
          setBanner(response1["response"]["banners"]);
        }
      }
    } else {
      _operatingArea = false;
      await setZoneId(null);
    }
    _isInitialized = true;
    notifyListeners();
  }

  gotoBusinessDetailPage(context, Business business) {
    // Business? business;
    if (business != null && business.businessType?.id != null) {
      String? business_type = business.businessType?.id!;
      if (business_type == BUSINESS_TYPE_STORE)
        Navigator.pushNamed(context, grocery_store_screen, arguments: {
          "store": business,
        });
      else
        Navigator.pushNamed(context, restaurant_detail_screen, arguments: {
          "store": business,
        });
    } else {
      showToast(
          "Unable to fetch store details, please consider adding manually");
    }
  }
}
