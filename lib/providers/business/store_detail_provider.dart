import 'dart:convert';
import 'dart:developer';

import 'package:absher/helpers/public_methods.dart';
import 'package:absher/models/category.dart';
import 'package:absher/models/restaurant.dart';
import 'package:flutter/cupertino.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../models/store_slider.dart';

class StoreDetailProvider extends ChangeNotifier {
  List<Category> _storeCategories = [];
  List<Category> _storeSubCategories = [];
  List<StoreSlider> _storeSliders = [];
  bool c_loading = false;
  Category? _selectedRestaurantCat;
  Category? _selectedRestaurantSubCat;
  Business? _business;

  List<Category> get storeCategories => _storeCategories;
  List<StoreSlider> get storeSliders => _storeSliders;

  List<Category> get storeSubCategories => _storeSubCategories;

  bool get loading {
    return c_loading;
  }

  Category? get selectedRestaurantCat {
    return _selectedRestaurantCat;
  }

  Category? get selectedRestaurantSubCat {
    return _selectedRestaurantSubCat;
  }

  Business? get business => _business;

  set loading(bool load) {
    c_loading = load;
    notifyListeners();
  }

  set business(Business? item) {
    _business = item;
    notifyListeners();
  }

  set selectedRestaurantCat(Category? cat) {
    _selectedRestaurantCat = cat;
    notifyListeners();
  }

  set selectedRestaurantSubCat(Category? cat) {
    _selectedRestaurantSubCat = cat;
    notifyListeners();
  }

  set storeCategories(List<Category> list) {
    _storeCategories.clear();
    _storeCategories.addAll(list);
    notifyListeners();
  }
  set storeSliders(List<StoreSlider> list) {
    _storeSliders.clear();
    _storeSliders.addAll(list);
    notifyListeners();
  }

  set storeSubCategories(List<Category> list) {
    _storeSubCategories.clear();
    _storeSubCategories.addAll(list);
    notifyListeners();
  }

  removeRestaurantCategories(index) {
    _storeCategories.removeAt(index);
    notifyListeners();
  }

  getData() async {
    c_loading = true;
    notifyListeners();

    dynamic response = await MjApiService()
        .getRequest(MJ_Apis.get_businees_detail + "/${_business!.id}");

    if (response != null) {
      Business item = Business.fromJson(response['response']);
      if (item is Business) {
        _business = item;
        Map<String, dynamic> payload = {
          "category_ids": json.encode(_business?.categoryIds ?? []),
          "restaurant_id": _business?.id
        };

        dynamic response2 = await MjApiService()
            .postRequest(MJ_Apis.categories_products, payload);

        if (response2 != null) {
          List<Category> tempList = [];
          for (int i = 0; i < response2['response']["data"].length; i++) {
            tempList.add(Category.fromJson(response2['response']["data"][i]));
          }
          _storeCategories = tempList;
        } else {
          logError("error in business_detail_provider, resposne is null: 201");
        }
      }
    }
    log("MJ: in no restaurant provider: ${_storeCategories.length}");
    c_loading = false;
    notifyListeners();
  }

  getSubCatData(Category cat) async {
    c_loading = true;
    if (cat.id != _selectedRestaurantCat?.id) {
      _selectedRestaurantCat = cat;
      _storeSubCategories = [];
    }
    notifyListeners();

    dynamic response = await MjApiService().getRequest(
        MJ_Apis.get_sub_categories +
            "/${_selectedRestaurantCat!.id}/${_business?.id}");

    if (response != null) {
      List<Category> tempList = [];
      for (int i = 0; i < response['response']["data"].length; i++) {
        tempList.add(Category.fromJson(response['response']["data"][i]));
      }
      _selectedRestaurantSubCat = tempList[0];
      c_loading = false;
      _storeSubCategories = tempList;
      logSuccess("MJ: subCatList length: ${tempList.length}");
      notifyListeners();
    } else {
      c_loading = false;
      _storeSubCategories = [];
      notifyListeners();
      logError("error in store_detail_provider, resposne is null: 501");
    }
  }

  getStoreSlider() async {

    dynamic response = await MjApiService().getRequest(
        MJ_Apis.get_businees_slider +
            "?id=${_business?.id}");

    if (response != null) {
      List<StoreSlider> tempList = [];
      for (int i = 0; i < response['response']["slider"].length; i++) {
        tempList.add(StoreSlider.fromJson(response['response']["slider"][i]));
      }
      _storeSliders.clear();
      _storeSliders.addAll(tempList);
      c_loading = false;
      log("MJ: slider in store length: ${tempList.length}");
      notifyListeners();
    } else {
      c_loading = false;
      _storeSliders.clear();
      notifyListeners();
      logError("error in store_slider_provider, resposne is null: 501");
    }
  }
}
