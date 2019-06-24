import 'package:flutter/material.dart';
import 'package:zhihu/commom/model/news.dart';
import 'package:zhihu/commom/router.dart';

class NewsItemWidget extends StatelessWidget {
  final News _news;

  const NewsItemWidget(this._news, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> _imageUrl = _news.images;
    return new GestureDetector(
      onTap: () {
        Router.push(context, Router.NewsDetails, _news.id);
      },
      child: new Card(
        margin: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
        child: new Padding(
          padding: EdgeInsets.all(12),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                child: new Text(
                  _news.title,
                  maxLines: 3,
                  style: new TextStyle(color: Color(0XFF3B3B3B), fontSize: 17),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              new Container(
                margin: EdgeInsets.only(left: 8),
                child: new Image.network(
                  _imageUrl[0],
                  width: 80,
                  height: 70,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeTitleWidget extends StatelessWidget {
  final String _title;

  const TimeTitleWidget(this._title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(left: 16, top: 16, bottom: 8),
      child: new Text(
        _title,
        style: TextStyle(color: Color(0XFF848484), fontSize: 14),
      ),
    );
  }
}
