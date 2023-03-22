import 'dart:convert';
import 'dart:developer';
import 'package:absher/helpers/constants.dart';
import 'package:absher/models/restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../helpers/public_methods.dart';
import '../../models/misc_models.dart';
import '../pagination_provider.dart';

class DeliveryPharmaProvider extends PaginationProvider<Business>{
  reset({bool empty_list = false, QueryParams? params = null}) async {
    c_reset(empty_list);
    return getData(empty_list: empty_list,
        params: params); //////////or -> return await getData();
  }
  getData({bool empty_list = true, QueryParams? params = null}) async {
    bool flag = c_getData(empty_list);
    if(flag){
    dynamic response = await MjApiService()
        .getRequest(MJ_Apis.get_all_restaurants+
        "?business_type=${BUSINESS_TYPE_PHARMACY}&offset=${c_offset}"
            "&limit=${c_limit}${getParametersForStores(params)}");
    c_refreshController.footerMode!.value = LoadStatus.idle;
    if (response != null) {
      c_total_size = response["response"]["total_size"];
      List<Business> tempList = [];
      for (int i = 0; i < response['response']["restaurants"].length; i++) {
        tempList.add(Business.fromJson(response['response']["restaurants"][i]));
      }
      c_getDataSecond(tempList, empty_list);
    }
    }

  }


}
