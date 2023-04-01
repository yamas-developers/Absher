import 'package:absher/helpers/constants.dart';
import 'package:absher/helpers/public_methods.dart';
import 'package:absher/models/restaurant.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../models/misc_models.dart';
import '../pagination_provider.dart';

class DeliveryRestaurantProvider extends PaginationProvider<Business> {
  // QueryParams? params;
  reset({QueryParams? params = null}) async {
    c_reset();
    return getData(
        params: params); //////////or -> return await getData();
  }

  getData({bool callingForMore = true, QueryParams? params = null}) async {
    bool flag = c_getData(callingForMore);
    if (flag) {
      dynamic response = await MjApiService().getRequest(MJ_Apis
              .get_delivery_restaurants +
          "?business_type=${BUSINESS_TYPE_RESTAURANT}&offset=${c_offset}"
              "&limit=${c_limit}${getParametersForStores(params)}");
      // c_refreshController.footerMode!.value = LoadStatus.idle;
      if (response != null){
        c_total_size = response["response"]["total_size"];
        List<Business> tempList = [];
        for (int i = 0; i < response['response']["restaurants"].length; i++) {
          tempList
              .add(Business.fromJson(response['response']["restaurants"][i]));
        }
        c_getDataSecond(tempList, callingForMore);
      }
    }
  }
}
