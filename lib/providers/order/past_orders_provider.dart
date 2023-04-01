import 'dart:convert';
import 'dart:developer';
import 'package:absher/models/restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../../models/order.dart';
import '../pagination_provider.dart';

class PastOrdersProvider extends PaginationProvider<Order>{
  reset() async {
    c_reset();
    return getData(callingForMore: false); //////////or -> return await getData();
  }
  getData({bool callingForMore = true}) async {
    bool flag = c_getData(callingForMore);
    if(flag){
    dynamic response = await MjApiService().getRequest(MJ_Apis.completed_order_list+
        "?offset=${c_offset}&limit=${c_limit}");

    c_refreshController.footerMode!.value = LoadStatus.idle;
    if (response != null) {
      c_total_size = response["response"]["total_size"];
      List<Order> tempList = [];
      for (int i = 0; i < response['response']["orders"].length; i++) {
        tempList.add(Order.fromJson(response['response']["orders"][i]));

      }
      c_getDataSecond(tempList, callingForMore);
    }
    }
  }


}
