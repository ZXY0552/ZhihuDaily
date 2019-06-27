import 'package:dio/dio.dart';
import 'package:zhihu/commom/config/config.dart';

class LogsInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    if (Config.DEBUG) {
      print("dio:请求url->>${options.baseUrl}${options.path}");
      if (options.data != null) {
        print('dio:请求参数->>' + options.data.toString());
      }
    }
    return options;
  }

  @override
  onResponse(Response response) {
    if (Config.DEBUG) {
      if (response != null) {
        print('dio:返回参数->>' + response.toString());
      }
    }
    return response; // continue
  }

  @override
  onError(DioError err) {
    if (Config.DEBUG) {
      print('dio:请求异常->>' + err.toString());
      print('dio:请求异常信息->>' + err.response?.toString() ?? "");
    }
    return err;
  }
}
