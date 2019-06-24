import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    String errorMsg = "";
    int statusCode;

    try {
      Response response;
      if (method == GET) {
        //组合GET请求的参数
        if (params != null && params.isNotEmpty) {
          StringBuffer sb = new StringBuffer("?");
          params.forEach((key, value) {
            sb.write("$key" + "=" + "$value" + "&");
          });
          String paramStr = sb.toString();
          paramStr = paramStr.substring(0, paramStr.length - 1);
          url += paramStr;
        }
        response = await _dio.get(url);
      } else {
        if (params != null && params.isNotEmpty) {
          response = await _dio.post(url, data: params);
        } else {
          response = await _dio.post(url);
        }
      }

      statusCode = response.statusCode;

      //处理错误部分
      if (statusCode < 0) {
        errorMsg = "网络请求错误,状态码:" + statusCode.toString();
        _handError(errorCallBack, errorMsg);
        return;
      }

      if (callBack != null) {
        callBack(response.data);
      }
    } catch (exception) {
      _handError(errorCallBack, exception.toString());
    }
  }

  //处理异常
  static void _handError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    } else {
      Fluttertoast.showToast(msg: errorMsg);
    }
  }
}

final HttpManager httpManager = new HttpManager();
