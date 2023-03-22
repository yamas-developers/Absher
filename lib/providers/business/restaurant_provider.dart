import 'dart:convert';
import 'dart:developer';
import 'package:absher/helpers/public_methods.dart';
import 'package:absher/models/category.dart';
import 'package:absher/models/category.dart';
import 'package:absher/models/misc_models.dart';
import 'package:absher/models/restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../helpers/constants.dart';
import '../no_pagination_provider.dart';
import '../pagination_provider.dart';

class RestaurantProvider extends ChangeNotifier {
  List<Category> _restaurantCategories = [];
  bool c_loading = false;
  String? _selectedRestaurantCat;
  // bool _showTopRated = false;
  // String? _searchedString;
  // double? _showWithStars;
  QueryParams _params = QueryParams();
  List<Category> get restaurantCategories => _restaurantCategories;

  bool get loading {
    return c_loading;
  }
  QueryParams get params {
    return _params;
  }
  String? get selectedRestaurantCat {
    return _selectedRestaurantCat;
  }
  // bool get showTopRated {
  //   return _showTopRated;
  // }
  // double? get showWithStars {
  //   return _showWithStars;
  // }
  // String? get searchedString {
  //   return _searchedString;
  // }
  // set showWithStars(double? val) {
  //   _showWithStars = val;
  //   notifyListeners();
  // }
  // set showTopRated(bool load) {
  //   _showTopRated = load;
  //   notifyListeners();
  // }
  // set searchedString(String? cat) {
  //   _searchedString = cat;
  //   notifyListeners();
  // }

  set params(QueryParams params) {
    _params = params;
    notifyListeners();
  }
  set loading(bool load) {
    c_loading = load;
    notifyListeners();
  }
  set selectedRestaurantCat(String? cat) {
    _selectedRestaurantCat = cat;
    notifyListeners();
  }
  set restaurantCategories(List<Category> list) {
    _restaurantCategories.clear();
    _restaurantCategories.addAll(list);
    notifyListeners();
  }



  removeRestaurantCategories(index) {
    _restaurantCategories.removeAt(index);
    notifyListeners();
  }

  getData({String? type = BUSINESS_TYPE_RESTAURANT}) async {
    c_loading = true;
    notifyListeners();

    dynamic response = await MjApiService().getRequest(
        MJ_Apis.categories + "?business_type=${type}");

    if (response != null) {
      // log("MJ: resposne != null ${response != null}");
      List<Category> tempList = [];
      for (int i = 0; i < response['response']["categories"].length; i++) {
        tempList.add(Category.fromJson(response['response']["categories"][i]));
      }
      _restaurantCategories = tempList;
      c_loading = false;
      notifyListeners();
      log("MJ: in no restaurant provider: ${_restaurantCategories.length}");
    }
  }
}
