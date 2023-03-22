import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../helpers/public_methods.dart';
import '../helpers/session_helper.dart';
import '../ui/registeration/login_screen.dart';
import 'mj_apis.dart';
import 'package:get/get.dart' as XGet;

class MjApiService {
  getMultiPartHeaders() async {
    if (await isLogin()) {
      var token = (await getSession())!;
      print('token: $token');
      String br = token;
      if (br == null) {
        showToast("Session Expired");
        XGet.Get.offAll(LoginScreen());
        return null;
      }
      return <String, String>{
        "Authorization": "Bearer " + br,
        "Accept": "json"
      };
    } else {
      return {
        "Accept": "application/json",
      };
    }
  }

  getHeaders({zoneId = null}) async {
    String br = '';
    String? token = await getSession();
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    if (await isLogin()) {
      if (token == null) {
        showToast("Session Expired");
        XGet.Get.offAll(LoginScreen());
        return null;
      }
      headers["Authorization"] = "Bearer " + token;
    }
    if (zoneId != null) {
      headers["zoneId"] = zoneId;
    }else{
      String? id = await getZoneId();
      if(id != null)headers["zoneId"] = id;
    }
    // log("headers: ${headers}");
    return headers;
  }

  temp() async {
    final Client client = http.Client();
    try {
      log('127.0.0.1:8000/api/websocket');
      final Response response = await client.get(
          Uri.parse('http://192.168.10.32:80/api/websocket'),);
    final hashMap = json.decode(response.body);
    log('MK: response: ${hashMap}');
    }catch(e){
    log('error: ${e}');

    }
  }

  Future<dynamic?> postRequest(String url, Map<String, dynamic> data,) async {
    final Client client = http.Client();
    try {
      dynamic headers = await getHeaders();

      final Response response = await http.post(
          Uri.parse('${MJ_Apis.BASE_URL}$url'),
          body: data,
          headers: headers);
      log('${MJ_Apis.BASE_URL}$url');
      log("MJ: here: ${data}");
      // log('myResponse ' + response.body);
      log('hashmap: ${response.body}');
      final hashMap = json.decode(response.body);

      if (hashMap['status_code'] == 1) {
        print("\x1B[30m in if");
        // String decData = await decryptString(hashMap['response']);
        dynamic decData = hashMap['response'];

        log('data is in if: ${decData}');
        // dynamic data = json.decode(decData);
        Map data = {};
        data["response"] = decData;
        data['message'] = hashMap['message'];
        data['status_code'] = hashMap['status_code'];
        log("${data}");
        return data;
      }

      showToast(hashMap['message']??'Unable to fetch server response');
      return null;
    } catch (e) {
      log(e.toString() + '=>$url');
      return null;
      // return MJResource<R>(MJStatus.ERROR, e.toString(), null); //e.message ??
    } finally {
      client.close();
    }
  }

  Future<dynamic?> postMultiPartRequest(url, Map<String, File> files,
      {Map<String, String>? data}) async {

    try {
      Uri uri = Uri.parse('${MJ_Apis.BASE_URL}$url');
      log('url: ${MJ_Apis.BASE_URL}$url');

      var request = MultipartRequest("POST", uri);

      for (int i = 0; i < files.length; i++) {
        request.files.add(await MultipartFile.fromPath(
            files.keys.elementAt(i), files[files.keys.elementAt(i)]!.path));
      }
      request.headers.addAll(await getHeaders());

      if (data != null) request.fields.addAll(data);
      var response = await request.send();

      var res = await http.Response.fromStream(response);
      log("MJ: response ${res.body.toString()}");


      final hashMap = json.decode(res.body);

      if (hashMap['status_code'] == 1) {
        print("\x1B[30m in if");
        // String decData = await decryptString(hashMap['response']);
        dynamic decData = hashMap['response'];

        log('data is in if: ${decData}');
        // dynamic data = json.decode(decData);
        Map data = {};
        data["response"] = decData;
        data['message'] = hashMap['message'];
        data['status_code'] = hashMap['status_code'];
        log("${data}");
        return data;
      }
      showToast(hashMap['message']);
      return null;
    } catch (exp) {
      print("MJ Error :" + exp.toString());
      showToast("Unfortunate Error");
      return null;
    }
  }

  Future<dynamic?> getRequest(String url, {zoneId = null}) async {
    print('in getRequest');
    final Client client = http.Client();
    try {
      log('${MJ_Apis.BASE_URL}$url');
      final Response response = await client.get(
          Uri.parse('${MJ_Apis.BASE_URL}$url'),
          headers: await getHeaders(zoneId: zoneId));

      // print(response.body.toString());
      final hashMap = json.decode(response.body);
      // print(hashMap);
      log('myHashmapStatus: ${hashMap}');
      if (hashMap['status_code'] == 1) {
        // String decData = await decryptString(hashMap['response']);
        Map<String, dynamic> decData = hashMap['response'];
        // print('data is in if: ${decData}');
        // dynamic data = jsonDecode(decData);
        Map data = {};
        data["response"] = decData;
        data['message'] = hashMap['message'];
        data['status_code'] = hashMap['status_code'];
        // log("\x1B[30m ${data}");
        return data;
      }
      showToast(hashMap['message']);
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    } finally {
      client.close();
    }
  }

  Future<dynamic?> multipartPostRequest(String url, Map data) async {
    try {
      print('${MJ_Apis.BASE_URL}$url');
      Uri uri = Uri.parse('${MJ_Apis.BASE_URL}$url');
      var request = http.MultipartRequest("POST", uri);

      request.fields['description'] = data['description'];
      request.headers.addAll(await getMultiPartHeaders());

      List<String?> imgPaths = data['image'];
      List<String?> videoPaths = data['video'];

      if (imgPaths.length >= 1) {
        for (var path in imgPaths) {
          request.files.add(await MultipartFile.fromPath('image[]', path!));
        }
      }
      if (videoPaths.length >= 1) {
        for (var path in videoPaths) {
          request.files.add(await MultipartFile.fromPath('video[]', path!));

          // request.files.add(http.MultipartFile('image', stream, length));
        }
        //File.fromUri(Uri.parse(path))
      }

      http.Response response =
          await http.Response.fromStream(await request.send());

      print('${MJ_Apis.BASE_URL}$url');
      print('myResponse ' + response.body.toString());

      final hashMap = json.decode(response.body);
      print('myHashmapStatus: ${hashMap['status']}');
      if (hashMap['status'] == 1) {
        // String decData = await decryptString(hashMap['response']);
        String decData = hashMap['response'];
        dynamic data = json.decode(decData);
        print('data is in if: ${data}');
        return data;
      }
      showToast(hashMap['message']);
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    } finally {}

    // if (response.statusCode == 200)
    //   ImageUrl =
    //   jsonDecode(response.body)['response']['url'];
  }
}
