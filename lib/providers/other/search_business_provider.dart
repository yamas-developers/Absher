import 'package:absher/models/restaurant.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../pagination_provider.dart';

class SearchBusinessProvider extends PaginationProvider<Business> {
  // SearchBusinessProvider(){
  //   getPopularRestaurants();
  // }
  List<Business> _popularBusiness = [];
  String _searchedString = "";

  String get searchedString => _searchedString;
  set searchedString(String val) {
    _searchedString = val;
    notifyListeners();
  }

  List<Business> get popularBusiness {
    return _popularBusiness;
  }

  set popularBusiness(List<Business> list) {
    _popularBusiness = list;
    notifyListeners();
  }

  reset({name = ""}) async {
    c_reset();
    return getData(
        name: name); //////////or -> return await getData();
  }

  getData({bool callingForMore = true, name = ""}) async {
    _searchedString = name??"";
    if (name == "" || name == null) {
      // reset();
      return;
    }
    bool flag = c_getData(callingForMore);
    if (flag) {
      dynamic response = await MjApiService().getRequest(MJ_Apis
              .get_searched_businees +
          "?name=${name}&offset=${c_offset}&limit=${c_limit}&type=delivery");
      c_refreshController.footerMode!.value = LoadStatus.idle;
      if (response != null) {
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

  getPopularRestaurants() async {
    if (_popularBusiness.isEmpty) {
      c_loading = true;
      notifyListeners();
    }
    dynamic response =
        await MjApiService().getRequest(MJ_Apis.get_popular_businees);
    if (response != null) {
      List<Business> tempList = [];
      for (int i = 0; i < response['response']["restaurants"].length; i++) {
        tempList.add(Business.fromJson(response['response']["restaurants"][i]));
      }
      _popularBusiness.clear();
      _popularBusiness.addAll(tempList);
    }
    c_loading = false;
    notifyListeners();
  }
}
