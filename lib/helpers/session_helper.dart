import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/mj_config.dart';

setSession(String? token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(
      MJConfig.mj_session_token, token??"");
}
// setUser(String? data) async {/////temp
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString(
//       "user_data", data??"");
// }
setZoneId(String? id) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(
      MJConfig.mj_zone_id, id??"");
}


//temp
// Future<String?> getUser() async {
//   try {
//     final prefs = await SharedPreferences.getInstance();
//     dynamic data = await prefs.getString("user_data");
//     if (data == null || data.isEmpty) {
//       return null;
//     }
//     print("success User data In SESSION HELPER");
//     return data;
//   } catch (e) {
//     return null;
//   }
// }

Future<String?> getSession() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    dynamic data = await prefs.getString(MJConfig.mj_session_token);
    if (data == null || data.isEmpty) {
      return null;
    }
    log("success User In SESSION HELPER: $data");
    return data;
  } catch (e) {
    return null;
  }
}
Future<String?> getZoneId() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    dynamic data = await prefs.getString(MJConfig.mj_zone_id);
    if (data == null || data.isEmpty) {
      return null;
    }
    return data;
  } catch (e) {
    return null;
  }
}

Future<bool> isLogin() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    String userData = await prefs.getString(MJConfig.mj_session_token)!;
    if (userData == null) {
      return false;
    }
    if (userData == '' || userData.isEmpty) {
      return false;
    } else {
      return true;
    }
  } catch (e) {
    return false;
  }
}
logout() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    bool res = await prefs.remove(MJConfig.mj_session_token);
    await prefs.remove("user_data");////temp
    if(res){
      return true;
    }else{
      return false;
    }
  } catch (e) {
    return false;
  }
}
