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
import '../../models/addons.dart';
import '../../models/product.dart';
import '../../models/variation.dart';
import '../no_pagination_provider.dart';
import '../pagination_provider.dart';

class ProductDetailProvider extends ChangeNotifier {
  bool c_loading = false;
  Product? _product;
  List<AddOns> _addOns = [];
  Variation? _variant;

  Variation? get variant => _variant;
  Product? get product => _product;
  List<AddOns> get addOns => _addOns;

  bool get loading {
    return c_loading;
  }

  set loading(bool load) {
    c_loading = load;
    notifyListeners();
  }

  set product(Product? item) {
    _product = item;
    notifyListeners();
  }
  set variant(Variation? item) {
    _variant = item;
    notifyListeners();
  }
  set addOns(List<AddOns> list) {
    _addOns = list;
    notifyListeners();
  }

  getData(String? id) async {
    logInfo("in product detail provider");
    if (id == null) return;
    c_loading = true;
    notifyListeners();

    dynamic response =
    await MjApiService().getRequest(MJ_Apis.get_product_detail + "/${id}");

    if (response != null) {
      Product? item = Product.fromJson(response['response']);
      _product = item;
      if (item is Product) {
        c_loading = false;
        _addOns = _product?.addOns??[];
        notifyListeners();
        log("MJ: in product_detail_provider catList: ${_product?.name}");
      } else {
        logError("error in product_detail_provider, resposne is null: 401");
      }
    }
  }
  isVariantSame(Variation? item){
    if(item== null || _variant== null)
    return false;
    if(item.type.toString() == _variant?.type.toString() && item.price.toString() == _variant?.price.toString())
      return true;
    else return false;
  }
}
