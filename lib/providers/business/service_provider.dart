import 'dart:convert';
import 'dart:developer';
import 'package:absher/helpers/constants.dart';
import 'package:absher/helpers/public_methods.dart';
import 'package:absher/models/restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../models/service.dart';
import '../pagination_provider.dart';

class ServiceProvider extends PaginationProvider<AbsherService>{
  reset() async {
    c_reset();
    return getData(); //////////or -> return await getData();
  }
  getData({bool callingForMore = true}) async {


    bool flag = c_getData(callingForMore);
    if(flag){

      try{
        dynamic response = await MjApiService()
            .getRequest(MJ_Apis.get_services+
            "?offset=${c_offset}&limit=${c_limit}");
        c_refreshController.footerMode!.value = LoadStatus.idle;
        if (response != null) {

          // c_total_size = response["response"]["total_size"];
          List<AbsherService> tempList = [];
          for (int i = 0; i < response['response']["services"].length; i++) {
            tempList.add(AbsherService.fromJson(response['response']["services"][i]));
          }
          log("calling get data in service provider: ");
          c_getDataSecond(tempList, callingForMore);
        }
      }catch(e){
        log("error in service provider: ${e}");
      }
    }

  }


}
