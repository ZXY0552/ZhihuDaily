import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zhihu/commom/model/latest.dart';
import 'package:zhihu/commom/model/news.dart';
import 'package:zhihu/commom/net/api.dart';
import 'package:zhihu/commom/net/api_address.dart';
import 'package:zhihu/widget/news_item.dart';

///专栏的新闻列表
class SectionNewsPage extends StatefulWidget {
  final String sectionId;

  const SectionNewsPage({Key key, this.sectionId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _SectionNewsState();
  }
}

class _SectionNewsState extends State<SectionNewsPage> {
  ///列表
  List<News> _stories = new List();
  bool isLoading = false;
  String _title;
  int _timestamp = 0;
  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels) {
        _onNextPage();
      }
    });
    _getData();
  }

  ///下一页
  _onNextPage() {
    if (isLoading) {
      return;
    }
    isLoading = true;
    _getData();
  }

  _getData() {
    String uri;
    if (_timestamp == 0) {
      uri = ApiAddress.sectionNews(widget.sectionId);
    } else {
      uri =
          "${ApiAddress.sectionNews(widget.sectionId)}/before/${_timestamp.toString()}";
    }

    httpManager.get(uri, (data) {
      LatestNews latestNews = LatestNews.fromJson(data);
      setState(() {
        _title = latestNews.name;
        isLoading = false;
        _timestamp = latestNews.timestamp;
        _stories.addAll(latestNews.stories);
      });
    }, errorCallBack: (errorMsg) {
      Fluttertoast.showToast(msg: errorMsg);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_title??""),
      ),
      body: new Container(
        child: new ListView.builder(
          controller: _controller,
          itemBuilder: (context, index) {
            return new NewsItemWidget(_stories[index]);
          },
          itemCount: _stories.length,
        ),
      ),
    );
  }
}
