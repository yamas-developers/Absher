import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../helpers/public_methods.dart';
import '../../helpers/session_helper.dart';
import '../../models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _currentUser;
  String? _token;
  bool _isLogin = false;
  MjApiService apiService = MjApiService();
  set user(User? user) {
    _currentUser = user;
    notifyListeners();
  }

  set token(String? token) {
    _token = token;
    notifyListeners();
  }
  set isLogin(bool val) {
    _isLogin = val;
    notifyListeners();
  }

  User? get currentUser => _currentUser;
  bool get isLogin => _isLogin;

  String? get token => _token;
  fetchUser() async {
    dynamic response =
        await apiService.getRequest(MJ_Apis.customer_info);
    if (response != null) {
      User user = User.fromJson(response["response"]);
      _currentUser = user;
      _isLogin = true;
    } else {
      await setSession(null);
      showToast(
          "Unable to fetch your data, please try consider trying again");
      _isLogin = false;
    }
    notifyListeners();
  }
  setUser(data) async {
    log("MJ: in setUser ${data}");
    if (data != null) {
      User user = User.fromJson(data);
      _currentUser = user;
      _isLogin = true;
    } else {
      await setSession(null);
      _isLogin = false;
    }
    notifyListeners();
  }
}
