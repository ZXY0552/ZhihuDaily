import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../cache_manage.dart';
import 'api_address.dart';
import 'interceptors/log_interceptor.dart';

class HttpManager {
  static const String GET = "get";
  static const String POST = "post";

  Dio _dio = new Dio(new BaseOptions(
      baseUrl: ApiAddress.host, receiveTimeout: 3000, connectTimeout: 5000));

  HttpManager() {
    _dio.interceptors.add(new LogsInterceptors());
  }

  //get请求
  void get(String url, Function callBack,
      {Map<String, String> params, Function errorCallBack}) async {
    _request(url, callBack,
        method: GET, params: params, errorCallBack: errorCallBack);
  }

  void _request(String url, Function callBack,
      {String method,
      Map<String, String> params,
      Function errorCallBack}) async {
    ///接口和参数拼接
    String urlParams = url;
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      urlParams += paramStr;
    }
    try {
      Response response;
      if (method == GET) {
        response = await _dio.get(urlParams);
      } else {
        if (params != null && params.isNotEmpty) {
          response = await _dio.post(url, data: params);
        } else {
          response = await _dio.post(url);
        }
      }
     await CacheManger().set(urlParams, response.toString());
      callBack(response.data);
    } on DioError catch (e) {
      ///请求失败 使用本地缓存
      String cacheData = await CacheManger().get(urlParams);
      if (cacheData != null) {
        callBack(jsonDecode(cacheData));
      } else {
        String errorMessage;
        switch (e.type) {
          case DioErrorType.CONNECT_TIMEOUT:
          case DioErrorType.SEND_TIMEOUT:
          case DioErrorType.RECEIVE_TIMEOUT:
            errorMessage = "请求超时";
            break;
          case DioErrorType.RESPONSE:
            errorMessage = "服务器响应错误";
            break;
          case DioErrorType.CANCEL:
            errorMessage = "请求被取消";
            break;
          case DioErrorType.DEFAULT:
            errorMessage = "网络连接失败";
            break;
        }
        _handError(errorCallBack, errorMessage);
      }
    } catch (e) {
      print(e.toString());
      _handError(errorCallBack, "未知错误");
    }
  }

  static void _handError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    } else {
      Fluttertoast.showToast(msg: errorMsg);
    }
  }

}

final HttpManager httpManager = new HttpManager();
