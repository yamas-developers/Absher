import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../models/order.dart';
import '../../models/order_detail.dart';

class OrderDetailProvider extends ChangeNotifier {
  Order? _orderItem;
  OrderDetail? _orderDetailItem;
  bool c_loading = false;
  String? _orderId;

  String? get orderId {
    return _orderId;
  }

  Order? get orderItem {
    return _orderItem;
  }

  OrderDetail? get orderDetailItem {
    return _orderDetailItem;
  }

  bool get loading {
    return c_loading;
  }

  set loading(bool load) {
    c_loading = load;
    notifyListeners();
  }

  set orderId(String? val) {
    _orderId = val;
    notifyListeners();
  }

  set orderItem(Order? val) {
    _orderItem = val;
    notifyListeners();
  }

  set orderDetailItem(OrderDetail? val) {
    _orderDetailItem = val;
    notifyListeners();
  }

  getData() async {
    c_loading = true;
    notifyListeners();
    dynamic response = await MjApiService()
        .getRequest(MJ_Apis.order_details + "?order_id=$_orderId");

    if (response != null) {
      OrderDetail item = OrderDetail.fromJson(response['response']["order"]);
      _orderDetailItem = item;
      _orderItem?.orderStatus = _orderDetailItem?.orderStatus;
    }
    c_loading = false;
    notifyListeners();
  }
}
