import 'dart:developer';

import 'package:absher/models/misc_models.dart';
import 'package:flutter/cupertino.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../helpers/public_methods.dart';
import '../../models/express_category.dart';

class ExpressProvider extends ChangeNotifier {
  ExpressAddress? _pickupAddress;
  ExpressAddress? _destinationAddress;
  List<ExpressCategry> _expressCategories = [];
  String? _description;
  String? _catId;
  MjApiService apiService = MjApiService();

  set expressCategories(List<ExpressCategry>? val) {
    _expressCategories = val ?? [];
    notifyListeners();
  }

  set pickupAddress(ExpressAddress? val) {
    _pickupAddress = val;
    notifyListeners();
  }

  set destinationAddress(ExpressAddress? val) {
    _destinationAddress = val;
    notifyListeners();
  }

  set description(String? val) {
    _description = val;
    notifyListeners();
  }

  set catId(String? val) {
    _catId = val;
    notifyListeners();
  }

  ExpressAddress? get pickupAddress => _pickupAddress;

  ExpressAddress? get destinationAddress => _destinationAddress;

  List<ExpressCategry>? get expressCategories => _expressCategories;

  String? get description => _description;

  String? get catId => _catId;

  fetchCategories() async {
    dynamic response =
        await apiService.getRequest(MJ_Apis.get_express_categories);
    if (response != null) {
      List<ExpressCategry> tempList = [];
      for (int i = 0; i < response['response']["categories"].length; i++) {
        tempList.add(
            ExpressCategry.fromJson(response['response']["categories"][i]));
      }
      _expressCategories.clear();
      _expressCategories.addAll(tempList);
      log("MJ: express categories ${_expressCategories.length}");
    }
    notifyListeners();
  }

  placeOrder(Map<String, dynamic> payload) async {
    dynamic response =
        await apiService.postRequest(MJ_Apis.get_express_place_order, payload);
    log("MJ: response ${response}");
    if (response != null) {
      showToast("Order placed successfully");
      _pickupAddress = null;
      _destinationAddress = null;
      _description = null;
      _catId = null;
      notifyListeners();
      return true;
    } else
      return false;
  }
}
