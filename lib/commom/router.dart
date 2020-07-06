import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zhihu/commom/model/news_details.dart';
import 'package:zhihu/commom/net/NetRespons.dart';
import 'package:zhihu/page/collect_page.dart';
import 'package:zhihu/page/commen_page.dart';
import 'package:zhihu/page/news_details.dart';
import 'package:zhihu/page/section_page.dart';
import 'package:zhihu/page/web_page.dart';
import 'package:zhihu/utils/html_utils.dart';

import 'net/api.dart';
import 'net/api_address.dart';

class Router {
  static const NEWS_DETAILS_PATH = 'app://newsDetails';
  static const WebView = "app://webView";
  static const NewsComment = "app://NewsComment";
  static const SectionNews = "app://sectionNews";
  static const CollectList = "app://CollectList";

  static const NewsDetailsNativeChannel = "zhihu.flutter.io/newsDetails";


  static Router _router = Router._();

  factory Router() {
    return _router;
  }

  Router._() {
    methodChannel.setMethodCallHandler(handleMethod);
  }

  final MethodChannel methodChannel = MethodChannel(NewsDetailsNativeChannel);

  Future<dynamic> invokeMapMethod(String method, [dynamic arguments]) async {
    return methodChannel.invokeMapMethod(method, arguments);
  }

  Future<dynamic> handleMethod(MethodCall methodCall) async {
    switch (methodCall.method) {
      case "getNewsDetails":
        final String newsId = methodCall.arguments;
        NetResponse netResponse =
            await HttpManager().execute(ApiAddress.newsDetails + newsId);
        if (netResponse.isSuccess) {
          NewsDetails newsDetails = NewsDetails.fromJson(netResponse.data);
          String html = HtmlUtils.formatNewsDetailsHtml(newsDetails, 1);
          return html;
        }
        break;
    }
  }

  Widget _getPage(String url, dynamic params) {
    switch (url) {
      case NEWS_DETAILS_PATH:
        return new NewsDetailsPage(params);
      case WebView:
        return new WebViewPage(params);
      case NewsComment:
        return new CommentPage(
          newsId: params["newsId"],
          comments: params["comments"],
        );
      case SectionNews:
        return new SectionNewsPage(
          sectionId: params,
        );
      case CollectList:
        return new CollectPage();
    }
    throw Exception("找不到$url路径");
  }

  pushNoParams(BuildContext context, String url) {
    push(context, url, null);
  }

  push(BuildContext context, String url, dynamic params) {
    if (Platform.isAndroid && url == NEWS_DETAILS_PATH) {
      invokeMapMethod("openNewsDetails", params);
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params);
    }));
  }
}
