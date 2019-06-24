import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:zhihu/commom/model/news_details.dart';
import 'package:zhihu/commom/model/news_story_extra.dart';
import 'package:zhihu/commom/net/api.dart';
import 'package:zhihu/commom/net/api_address.dart';
import 'package:zhihu/commom/router.dart';
import 'package:zhihu/utils/html_utils.dart';
import 'package:zhihu/widget/bar_icon_actions.dart';

class NewsDetailsPage extends StatefulWidget {
  final int newsId;

  const NewsDetailsPage(this.newsId, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _NewsDetailsPageState();
  }
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  NewsDetails _newsDetails;
  NewsStoryExtra _newsStoryExtra;

  @override
  void initState() {
    super.initState();
    _getNewsDetail();
    _getNewsStoryExtra();

  }

  void _getNewsDetail() {
    httpManager.get(ApiAddress.newsDetails + widget.newsId.toString(), (data) {
      setState(() {
        _newsDetails = NewsDetails.fromJson(data);
      });
    });
  }

  void _getNewsStoryExtra() {
    httpManager.get(ApiAddress.newsStoryExtra + widget.newsId.toString(),
        (data) {
      setState(() {
        _newsStoryExtra = NewsStoryExtra.fromJson(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_newsDetails == null) {
      body = new Container();
    } else {
      body = new InAppWebView(
          initialUrl: HtmlUtils.formatNewsDetailsHtml(_newsDetails),
          initialOptions: {
            "useShouldOverrideUrlLoading": true,
          },
          shouldOverrideUrlLoading: (controller, url) {
            if (url.startsWith("http:") || url.startsWith("https:")) {
              Router.push(context, Router.WebView, url);
            } else {}
            return true; //用浏览器打开
          });
    }

    final String comments =
        _newsStoryExtra == null ? "" : _newsStoryExtra.comments.toString();
    final String popularity =
        _newsStoryExtra == null ? "" : _newsStoryExtra.popularity.toString();

    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          new AppBarIcoAction(
            icon: new Icon(Icons.share, color: Colors.white),
          ),
          new AppBarIcoAction(
            icon: new Icon(Icons.star, color: Colors.white),
          ),
          new AppBarIcoAction(
            icon: new Icon(
              Icons.message,
              color: Colors.white,
            ),
            labelText: comments,
            callback: () {
              Router.push(context, Router.NewsComment, {'newsId': widget.newsId, 'comments': comments});
            },
          ),
          new AppBarIcoAction(
            icon: Image.asset("static/images/praise.png", width: 30),
            labelText: popularity,
          ),
          new Padding(padding: EdgeInsets.all(12))
        ],
      ),
      body: body,
    );
  }
}
