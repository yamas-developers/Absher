import 'dart:developer';

import 'package:absher/helpers/public_methods.dart';
import 'package:absher/models/restaurant.dart';
import 'package:flutter/cupertino.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../models/product.dart';

class FavoriteProvider extends ChangeNotifier {
  bool c_loading = false;
  List<Product> _favoriteProducts = [];
  List<Business> _favoritesBusiness = [];

  List<Product> get favoriteProducts => _favoriteProducts;

  List<Business> get favoritesBusiness => _favoritesBusiness;

  bool get loading {
    return c_loading;
  }

  set loading(bool load) {
    c_loading = load;
    notifyListeners();
  }

  set favoritesProducts(List<Product>? list) {
    _favoriteProducts = list ?? [];
    notifyListeners();
  }

  set favoritesBusiness(List<Business>? list) {
    _favoritesBusiness = list ?? [];
    notifyListeners();
  }

  getData(String? id) async {
    logInfo("in favorite");
    if (id == null) return;
    c_loading = true;
    notifyListeners();

    dynamic response =
        await MjApiService().getRequest(MJ_Apis.get_favorites + "/${id}");

    if (response != null) {
      List<Product> tempProducts = [];
      List<Business> tempBusiness = [];

      for (int i = 0; i < response['response']["food"].length; i++) {
        tempProducts.add(Product.fromJson(response['response']["food"][i]));
      }
      for (int i = 0; i < response['response']["restaurant"].length; i++) {
        tempBusiness
            .add(Business.fromJson(response['response']["restaurant"][i]));
      }
      c_loading = false;
      _favoritesBusiness = tempBusiness;
      _favoriteProducts = tempProducts;
      notifyListeners();
      log("MJ: in favorite provider catList: ${tempBusiness.length}, ${tempProducts.length}");
    }
  }

  removeFavoriteProduct(String? userId, String? productId) async {
    Map<String, dynamic> payload = {"user_id": userId, "food_id": productId};

    dynamic response2 =
        await MjApiService().postRequest(MJ_Apis.remove_favorites, payload);
    _favoriteProducts.removeWhere((element) => element.id == productId);
    notifyListeners();
  }
  removeFavoriteBusiness(String? userId, String? businessId) async {
    Map<String, dynamic> payload = {"user_id": userId, "restaurant_id": businessId};

    dynamic response2 =
    await MjApiService().postRequest(MJ_Apis.remove_favorites, payload);
    _favoritesBusiness.removeWhere((element) => element.id == businessId);
    notifyListeners();
  }
  addFavoriteBusiness(String? userId, String? id) async {
    Map<String, dynamic> payload = {"user_id": userId, "restaurant_id": id};

    dynamic response2 =
    await MjApiService().postRequest(MJ_Apis.add_favorites, payload);
    // _favoritesBusiness.add(business);
    // notifyListeners();
  }
  addFavoriteProduct(String? userId, String? id) async {
    Map<String, dynamic> payload = {"user_id": userId, "food_id": id};

    dynamic response2 =
    await MjApiService().postRequest(MJ_Apis.add_favorites, payload);
    // _favoriteProducts.add(product);
    // notifyListeners();
  }
}
