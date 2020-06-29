import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:zhihu/commom/db/collect_db.dart';
import 'package:zhihu/commom/model/news_details.dart';
import 'package:zhihu/commom/model/news_story_extra.dart';
import 'package:zhihu/commom/net/api.dart';
import 'package:zhihu/commom/net/api_address.dart';
import 'package:zhihu/commom/router.dart';
import 'package:zhihu/commom/style/theme_style.dart';
import 'package:zhihu/utils/html_utils.dart';
import 'package:zhihu/widget/bar_icon_actions.dart';

///文章详情
class NewsDetailsPage extends StatefulWidget {
  final int newsId;

  const NewsDetailsPage(this.newsId, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _NewsDetailsPageState();
  }
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  CollectDb _collectDb = new CollectDb();
  NewsDetails _newsDetails;
  NewsStoryExtra _newsStoryExtra;

  ///是否收藏
  bool _isCollect = false;

  @override
  void initState() {
    super.initState();
    _getNewsDetail();
    _getNewsStoryExtra();
    _getCollect();
  }

  @override
  void dispose() {
    super.dispose();
    _collectDb.close();
  }

  ///检查是否添加了收藏
  void _getCollect() async {
    CollectData collectData = await _collectDb.get(widget.newsId);
    if (collectData != null) {
      _isCollect = true;
    } else {
      _isCollect = false;
    }
    setState(() {});
  }

  ///添加收藏
  void _addCollect() async {
    if (_newsDetails != null) {
      int count =
          await _collectDb.set(CollectData.formNewsDetails(_newsDetails));
      if (count > 0) {
        _getCollect();
      }
    } else {
      Fluttertoast.showToast(msg: "收藏失败,请稍后再试");
    }
  }

  ///删除收藏
  void _delCollect() async {
    int count = await _collectDb.delete(widget.newsId);
    if (count > 0) {
      _getCollect();
    }
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
          initialUrl: HtmlUtils.formatNewsDetailsHtml(
              _newsDetails, ThemeStyle.of(context).themeMode),
          initialOptions: new InAppWebViewGroupOptions(
            crossPlatform: new InAppWebViewOptions(
              useShouldOverrideUrlLoading: true,
            )
          ),
          shouldOverrideUrlLoading: (controller, url) async {
            var urlPath = url.url;
            if (urlPath.startsWith("http:") || urlPath.startsWith("https:")) {
              Router.push(context, Router.WebView, url);
            } else if (urlPath.startsWith("section://")) {
              List<String> sectionNewInfo = urlPath.split("//");

              Router.push(context, Router.SectionNews,
                  sectionNewInfo[sectionNewInfo.length - 1]);
            }
            return ShouldOverrideUrlLoadingAction.CANCEL; //用浏览器打开
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
            callback: () {
              Share.share(
                  "${_newsDetails.title}（分享自@知乎日报APP）${_newsDetails.shareUrl}");
            },
            icon: new Icon(Icons.share, color: Colors.white),
          ),
          new AppBarIcoAction(
            callback: () {
              if (_isCollect) {
                _delCollect();
              } else {
                _addCollect();
              }
            },
            icon: new Icon(Icons.star,
                color: _isCollect ? Colors.orange : Colors.white),
          ),
          new AppBarIcoAction(
            icon: new Icon(
              Icons.message,
              color: Colors.white,
            ),
            labelText: comments,
            callback: () {
              Router.push(context, Router.NewsComment,
                  {'newsId': widget.newsId, 'comments': comments});
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
