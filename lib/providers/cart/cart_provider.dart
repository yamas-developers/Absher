import 'dart:convert';
import 'dart:developer';

import 'package:absher/helpers/db/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../helpers/public_methods.dart';
import '../../models/cart.dart';
import '../../models/product.dart';
import '../../models/restaurant.dart';
import '../location/location_provider.dart';
import '../user/user_provider.dart';

class CartProvider extends DBHelper<Cart> with ChangeNotifier, MjApiService {
  CartProvider() {
    init(Cart(), Cart.query, Cart.STORE_NAME);
    getCartData();
  }

  List<Cart> _list = [];
  List<Product> _cartProductList = [];
  int _cartTotal = 0;
  String _currentStoreId = '0';
  Business? _currentStore;

  int get cartTotal => _cartTotal;

  String get currentStoreId => _currentStoreId;

  Business? get currentStore => _currentStore;
  bool _loading = false;

  List<Cart> get list => _list;

  List<Product> get cartProductList => _cartProductList;

  bool get loading => _loading;

  Future<void> calculateCartTotal() async {
    // var data = await getCartData();
    _cartTotal = 0;
    for (Cart item in _list) {
      int addOns = 0;
      for (int i = 0; i < (item.addOns?.length ?? 0); i++) {
        if (item.addOns![i].available)
          addOns += convertNumber(item.addOns![i].price) *
              convertNumber(item.addOns![i].qty);
      }
      if (item.available)
        _cartTotal +=
            (convertNumber(item.price) + addOns) * convertNumber(item.qty);
    }
    log("MJ: cart total: ${_cartTotal}");
    notifyListeners();
    // return _cartTotal;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  set list(List<Cart> value) {
    _list.clear();
    _list.addAll(value);
    notifyListeners();
  }

  set cartProductList(List<Product> value) {
    _cartProductList.clear();
    _cartProductList.addAll(value);
    notifyListeners();
  }

  checkCartForProduct(productId, storeId) {
    for (Cart item in _list) {
      if (item.storeId != storeId) return null;
      if (item.storeProductId == productId) {
        return {"cartId": item.id, "quantity": item.qty};
      }
    }
  }

  Future<bool> addToCart({Cart? cartItem}) async {
    _loading = true;
    if (_currentStoreId != '0') {
      if (_currentStoreId != cartItem?.storeId.toString()) {
        await clearCart();
      }
    } else {
      _list = Cart().fromMapList(await getAll());
      if (_list.isNotEmpty) {
        _currentStoreId = _list.first.storeId ?? '0';
        if (_currentStoreId != '0' &&
            _currentStoreId != cartItem?.storeId.toString()) {
          await clearCart();
        }
      }
    }
    _currentStoreId = cartItem?.storeId.toString() ?? "0";
    getBusiness();
    Cart? item = _list.firstWhereOrNull(
        (element) => element.storeProductId == cartItem?.storeProductId);
    log("MJ: product0 ${item} and ${_list.length} _${_currentStoreId}");
    if (item != null) {
      // _list.remove(item);
      removeFromCart(item.id);
    }
    log("MJ: product ${cartItem?.title} and ${_list.length}");
    var data = await insert(cartItem!);
    cartItem.id = data.toString();
    _list.add(cartItem);
    log("cart data from db: ${data}");
    await getCartData();
    loading = false;
    notifyListeners();
    return data != null;
  }

  Future<void> updateProductCartQuantity(String id, int quantity) async {
    if (quantity < 1) {
      print('quantity less than one');
      removeFromCart(id);
      await getCartData();
      notifyListeners();
      return;
    }
    _list.forEach((element) {
      if (element.id == id) {
        element.qty = quantity.toString();
        notifyListeners();
      }
    });
    await updateWhere(['qty'], [quantity.toString()], ['id'], [id.toString()]);
    await getCartData();
  }

  Future<void> removeFromCart(cartId) async {
    // get
    log("MK: ${cartId}");
    _list.removeWhere((element) => element.id == cartId);
    await deleteOne('id', cartId);
    notifyListeners();
    // return data != null;
  }

  Future<bool> clearCart() async {
    var data = await deleteAll();
    _currentStoreId = "0";
    _currentStore = null;
    await getCartData();
    return data != null;
  }

  getCartData() async {
    log("MJ in getCartData: ${await getAll()}");
    _list = Cart().fromMapList(await getAll());
    if (_list.length > 0) {
      _currentStoreId = _list.first.storeId ?? "0";
      if (_currentStoreId != "0" &&
          _currentStore == null &&
          _currentStore?.id != _currentStoreId) {
        getBusiness();
      }
    }
    log('list from db: ${_list.map((e) => e.toMap(e))}');
    log("MJ: cart length: ${_list.length}");
    calculateCartTotal();
    // await getStoreProducts();
    notifyListeners();
    return true;
  }

  refreshCart() async {
    // await clearCart();
    List<Product> newList = [];
    List<String> ids = [];
    _list.forEach((element) {
      ids.add(element.storeProductId!);
    });
    Map<String, dynamic> payload = {"ids": json.encode(ids)};

    dynamic response =
        await MjApiService().postRequest(MJ_Apis.sync_all_products, payload);

    if (response != null) {
      // log("MJ: response: ${response}");
      for (int i = 0; i < response['response']["data"].length; i++) {
        newList.add(Product.fromJson(response['response']["data"][i]));
      }
    }
    var data = await deleteAll();

    for (Cart item in _list) {
      bool flag = false;
      newList.forEach((element) {
        if (element.id == item.storeProductId) {
          flag = true;
          item.available = true;
          item.addOns?.forEach((e) {
            bool flag2 = false;
            element.addOns?.forEach((el) {
              if (e.id == el.id) {
                e.available = true;
                flag2 = true;
              }
            });
            if (!flag2) e.available = false;
          });
        }
      });
      if (!flag) item.available = false;
    }
    for (Cart item in _list) {
      await insert(item);
    }
    calculateCartTotal();
    notifyListeners();
  }

  getBusiness() async {
    if (_currentStoreId == "0") return;
    if (_currentStoreId == _currentStore?.id) return;
    dynamic response = await MjApiService()
        .getRequest(MJ_Apis.get_businees_detail + "/${_currentStoreId}");
    if (response != null) {
      _currentStore = Business.fromJson(response['response']);
    }
    // notifyListeners();
  }

  placeOrder(BuildContext context) async {
    UserProvider userProvider = context.read<UserProvider>();
    LocationProvider locationProvider = context.read<LocationProvider>();

    if (!userProvider.isLogin || userProvider.currentUser == null) {
      showToast("Please login to proceed");
      return;
    }
    // {
    //   "food_id": 3,
    // "variation": [{"type":"Small","price":100}],
    // "add_on_ids":[12,14],
    // "add_on_qtys":[1,1],
    // "quantity": 2,
    // "variant": "Small"
    // }

    List cartList = [];
    for (Cart item in _list) {
      Map datum = {
        "food_id": item.storeProductId,
        "variation": [item.variant?.toJson() ?? ""],
        "add_on_ids": item.addOns?.map((e) => e.id ?? "").toList(),
        "add_on_qtys": item.addOns?.map((e) => e.qty ?? "").toList(),
        "quantity": item.qty,
        "variant": "${item.variant?.type ?? ""}"
      };
      cartList.add(datum);
    }

    double distance = 0; /////////////////

    Map<String, dynamic> payload = {
      "order_amount": _cartTotal.toString(),
      "payment_method": "cash_on_delivery",
      "order_type": "delivery",
      "restaurant_id": _currentStoreId,
      "distance": "$distance",
      "address": locationProvider.address,
      "longitude": "${locationProvider.currentLocation.longitude}",
      "latitude": "${locationProvider.currentLocation.latitude}",
      "contact_person_name":
          "${userProvider.currentUser?.fName ?? ""} ${userProvider.currentUser?.lName ?? ""}",
      "contact_person_number": "${userProvider.currentUser?.phone ?? ""}",
      "address_type": "Delivery Address",
      "floor": "",
      "road": "",
      "house": "",
      "dm_tips": "0.0",
      "order_note": "",
      "otp": "0000",
      "cart": json.encode(cartList)
    };

    log("MJ: cart data for order: ${payload}");
    // return;

    showProgressDialog(context, "Placing Order");
    dynamic response =
        await MjApiService().postRequest(MJ_Apis.place_order, payload);
    log("MJ: response ${response}");
      hideProgressDialog(context);
    if (response != null) {
      showToast("Order placed successfully");
      clearCart();
      Navigator.pop(context);
      // notifyListeners();
      return true;
    } else
      return false;

    //
  }
}
