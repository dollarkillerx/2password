import 'package:password2/common/library/common.dart';
import '../storage/user.dart';
import 'dart:convert';

enum HttpMethod { GET, POST, DELETE }

abstract class BaseRequest {
  Map<String, dynamic> queryParameters = {}; // query
  Map<String, dynamic> params = {}; // data
  Map<String, String> header = {}; // header
  bool neeLogin();

  String authority() {
    return SERVER_API_URL2;
  }

  HttpMethod httpMethod();

  String path();

  Future<Uri> uri() async {
    Uri ui;
    var pathStr = path();
    if (pathStr != "") {
      if (path().endsWith("/")) {
        pathStr = "/api/v1" + pathStr;
      } else {
        pathStr = "/api/v1" + "/$pathStr";
      }
    }

    if (userHttps) {
      ui = Uri.https(authority(), pathStr, queryParameters);
    } else {
      ui = Uri.http(authority(), pathStr, queryParameters);
    }

    if (neeLogin()) {
      String? rx = await AppData.getJWT();
      if (rx != null) {
        addHeader(JWTHeader, rx);
      }
    }

    return ui;
  }

  // add params
  BaseRequest add(String k, dynamic v) {
    params[k] = v;
    return this;
  }

  // set params
  BaseRequest setParam(Map<String, dynamic> v) {
    params = v;
    return this;
  }

  // add params
  BaseRequest query(String k, Object v) {
    queryParameters[k] = v.toString();
    return this;
  }

  // add header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}

// 网络请求抽象类
abstract class HiNetAdapter {
  Future<HiNetResponse<T>> send<T>(BaseRequest request);
}

// 同意返回格式
class HiNetResponse<T> {
  T? data;  // data
  late BaseRequest request;
  late int statusCode;
  dynamic extra; // 其他数据

  HiNetResponse(
      {this.data, required this.request, required this.statusCode, this.extra});

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }

    return data.toString();
  }
}