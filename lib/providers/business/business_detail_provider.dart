import 'dart:convert';
import 'dart:developer';
import 'package:absher/helpers/public_methods.dart';
import 'package:absher/models/category.dart';
import 'package:absher/models/category.dart';
import 'package:absher/models/restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../helpers/constants.dart';
import '../no_pagination_provider.dart';
import '../pagination_provider.dart';

class BusinessDetailProvider extends ChangeNotifier {
  List<Category> _businessCategories = [];
  bool c_loading = false;
  String? _selectedBusinessCat;
  Business? _business;

  List<Category> get businessCategories => _businessCategories;

  Business? get business => _business;

  bool get loading {
    return c_loading;
  }

  String? get selectedRestaurantCat {
    return _selectedBusinessCat;
  }

  set loading(bool load) {
    c_loading = load;
    notifyListeners();
  }

  set business(Business? item) {
    _business = item;
    notifyListeners();
  }

  set selectedBusinessCat(String? cat) {
    _selectedBusinessCat = cat;
    notifyListeners();
  }

  set businessCategories(List<Category> list) {
    _businessCategories.clear();
    _businessCategories.addAll(list);
    notifyListeners();
  }

  removeRestaurantCategories(index) {
    _businessCategories.removeAt(index);
    notifyListeners();
  }

  getData() async {
    logInfo("in detail provider");
    c_loading = true;
    notifyListeners();

    dynamic response = await MjApiService()
        .getRequest(MJ_Apis.get_businees_detail + "/${_business!.id}");


    if (response != null) {
      Business item = Business.fromJson(response['response']);
      if (item is Business) {
        _business = item;

        Map<String, dynamic> payload = {
          "category_ids": json.encode(_business?.foodCategoryIds),
          "restaurant_id": _business?.id
        };

        dynamic response2 = await MjApiService()
            .postRequest(MJ_Apis.categories_products, payload);

          // log("MJ: response: ${response2}");
        if (response2 != null) {
          List<Category> tempList = [];
          for (int i = 0; i < response2['response']["data"].length; i++) {
            tempList.add(Category.fromJson(response2['response']["data"][i]));
          }
          _businessCategories.clear();
          _businessCategories.addAll(tempList);
        } else {
          logError("error in business_detail_provider, resposne is null: 201");
        }
      } else {
        logError("error in business_detail_provider: 301");
      }

      c_loading = false;
      notifyListeners();
      log("MJ: in business detail provider catList: ${_businessCategories.length}");
    } else {
      logError("error in business_detail_provider, resposne is null: 401");
    }
  }
}
