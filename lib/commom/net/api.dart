import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../cache_manage.dart';
import 'NetRespons.dart';
import 'api_address.dart';
import 'interceptors/log_interceptor.dart';

class HttpManager {
  static const String GET = "get";
  static const String POST = "post";

  Dio _dio = new Dio(new BaseOptions(
      baseUrl: ApiAddress.host, receiveTimeout: 3000, connectTimeout: 5000));

  static HttpManager httpManager = new HttpManager._();

  HttpManager._() {
    _dio.interceptors.add(new LogsInterceptors());
  }

  factory HttpManager() {
    return httpManager;
  }

  Future<NetResponse> execute(String url, {Map<String, String> params}) async {
    return await _request(url, params: params);
  }

  //get请求
  Future<Null> enqueue(String url, Function callBack,
      {Map<String, String> params, Function errorCallBack}) async {
    NetResponse netResponse = await _request(url, params: params);
    if (netResponse.isSuccess) {
      callBack(netResponse.data);
    } else {
      _handError(errorCallBack, netResponse.errorMessage);
    }
  }

  Future<NetResponse> _request(String url, {Map<String, String> params}) async {
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
      response = await _dio.get(urlParams);
      CacheManger().set(urlParams, response.toString());
      return new NetResponse(true, data: response.data);
    } on DioError catch (e) {
      ///请求失败 使用本地缓存
      String cacheData = await CacheManger().get(urlParams);
      if (cacheData != null) {
        return new NetResponse(true, data: jsonDecode(cacheData));
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
        return new NetResponse(false, errorMessage: errorMessage);
      }
    } catch (e) {
      print(e.toString());
      return new NetResponse(false, errorMessage: "未知错误");
    }
  }

  void _requestEnqueue(String url, Function callBack,
      {String method,
      Map<String, String> params,
      Function errorCallBack}) async {}

  static void _handError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    } else {
      Fluttertoast.showToast(msg: errorMsg);
    }
  }
}

final HttpManager httpManager = new HttpManager();
