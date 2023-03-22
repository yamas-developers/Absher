import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/restaurant.dart';

class PaginationProvider<T> with ChangeNotifier{
  List<T> c_list = [];
  RefreshController c_refreshController = RefreshController();
  int c_limit = 10;
  int c_offset = 1;
  int c_total_size = 10000;
  bool c_loading = false;

  List<T> get list => c_list;
  RefreshController get refreshController => c_refreshController;

  set loading(bool load){
    c_loading = load;
    notifyListeners();
  }
  bool get loading{
    return c_loading;
  }

  set list(List<T> list) {
    c_list.clear();
    c_list.addAll(list);
    notifyListeners();
  }
  set refreshController(RefreshController refreshController) {
    c_refreshController = refreshController;
    notifyListeners();
  }

  remove(index) {
    c_list.removeAt(index);
    notifyListeners();
  }

  c_reset(bool empty_list){
    c_offset = 1;
    c_total_size = 1000;
    c_loading = false;
    if(empty_list)
    c_list = [];
    c_refreshController.loadComplete();
    notifyListeners();
  }
  c_getData(bool empty_list){ //////empty list should be true for first call
    log("MJ: offset is $c_offset and total_size is $c_total_size");
    if(c_offset==1) { ////first time
      if(empty_list)
      c_list.clear();
    }else{ ////called for more data
    }
    // notifyListeners();
    log("MJ: length is ${c_list.length}");
      c_refreshController.footerMode?.value = LoadStatus.loading;

    if (c_offset > c_total_size) {
      c_refreshController.footerMode?.value = LoadStatus.noMore;
      return false;
    }
    c_loading = true;
    notifyListeners();
    return true;
  }
  c_getDataSecond(list, bool empty_list){
    if(empty_list)
    c_list.addAll(list);
    else {
    c_list = list ;
    }
    c_loading = false;
    c_refreshController.refreshCompleted();
    c_offset += c_limit;
    notifyListeners();
    log("MJ: in Provider: ${c_total_size}, ${c_total_size}, ${c_limit}, ${c_offset}");

  }


}