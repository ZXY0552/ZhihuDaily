import 'package:flutter/material.dart';
import 'package:zhihu/page/commen_page.dart';
import 'package:zhihu/page/news_details.dart';
import 'package:zhihu/page/web_page.dart';

class Router {
  static const NewsDetails = 'app://newsDetails';
  static const WebView = "app://webView";
  static const NewsComment = "app://NewsComment";

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
    }
  }

  Router.pushNoParams(BuildContext context, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, null);
    }));
  }

  Router.push(BuildContext context, String url, dynamic params) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params);
    }));
  }
}