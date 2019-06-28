import 'package:flutter/material.dart';
import 'package:zhihu/commom/db/collect_db.dart';
import 'package:zhihu/commom/model/news.dart';
import 'package:zhihu/commom/style/theme_style.dart';
import 'package:zhihu/widget/news_item.dart';

///本地收藏列表
class CollectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CollectPageState();
  }
}

class _CollectPageState extends State<CollectPage> {
  CollectDb _collectDb = new CollectDb();
  List<News> _newsList;

  @override
  void initState() {
    super.initState();
    _getCollectList();
  }

  @override
  void deactivate() {
    super.deactivate();
    _getCollectList();
  }

  @override
  void dispose() {
    super.dispose();
    _collectDb.close();
  }

  _getCollectList() async {
    _newsList = await _collectDb.getAll();
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget collectList;
    if (_newsList == null || _newsList.length == 0) {
      collectList = new Center(
        child: Text(
          "空空如也",
          style: new TextStyle(
              color: ThemeStyle.of(context).textColorLightMedium, fontSize: 16),
        ),
      );
    } else {
      collectList = new ListView.builder(
        itemBuilder: (context, index) {
          return new NewsItemWidget(_newsList[index]);
        },
        itemCount: _newsList.length,
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("我的收藏"),
      ),
      body: new Container(
        child: collectList,
      ),
    );
  }
}
