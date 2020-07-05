import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zhihu/page/collect_page.dart';
import 'package:zhihu/page/commen_page.dart';
import 'package:zhihu/page/news_details.dart';
import 'package:zhihu/page/section_page.dart';
import 'package:zhihu/page/web_page.dart';

class Router {
  static const NewsDetails = 'app://newsDetails';
  static const WebView = "app://webView";
  static const NewsComment = "app://NewsComment";
  static const SectionNews = "app://sectionNews";
  static const CollectList = "app://CollectList";

  static const NewsDetailsNativeChannel = "zhihu.flutter.io/newsDetails";

  final MethodChannel methodChannel = MethodChannel(NewsDetailsNativeChannel);

  Router() {
    methodChannel.setMethodCallHandler(handleMethod);
  }

  Future<dynamic> invokeMapMethod(String method, [dynamic arguments]) async {
    return methodChannel.invokeMapMethod(method, arguments);
  }

  Future<dynamic> handleMethod(MethodCall methodCall) async {}

  Widget _getPage(String url, dynamic params) {
    switch (url) {
      case NewsDetails:
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
  }

  Router.pushNoParams(BuildContext context, String url) {
    Router.push(context, url, null);
  }

  Router.push(BuildContext context, String url, dynamic params) {
    if (Platform.isAndroid && url == NewsDetails) {
      invokeMapMethod("openNewsDetails", params);
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params);
    }));
  }
}
