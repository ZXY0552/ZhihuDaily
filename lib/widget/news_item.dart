import 'package:flutter/material.dart';
import 'package:zhihu/commom/model/news.dart';
import 'package:zhihu/commom/router.dart';
import 'package:zhihu/commom/style/theme_style.dart';

class NewsItemWidget extends StatelessWidget {
  final News _news;

  const NewsItemWidget(this._news, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> _imageUrl = _news.images;
    Widget imageContainer = new Container();
    Widget image;

    if (_imageUrl.length > 0) {
      image = new Image.network(
        _imageUrl[0],
        width: 105,
        height: 80,
        fit: BoxFit.fitWidth,
      );
    }

    if (_news.multipic != null && _news.multipic) {
      imageContainer = new Container(
        margin: EdgeInsets.only(left: 8),
        child: new Stack(children: <Widget>[
          new Stack(
            children: <Widget>[
              image,

              ///多图tag
              new Positioned(
                child: new Image.asset(
                  "static/images/home_pic.png",
                  height: 16,
                ),
                right: 0,
                bottom: 0,
              ),
            ],
          )
        ]),
      );
    } else {
      imageContainer = new Container(
        margin: EdgeInsets.only(left: 8),
        child: image,
      );
    }

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
                child: Container(
                  height: 70,
                  child: new Stack(
                    children: <Widget>[
                      new Text(
                        _news.title,
                        maxLines: 2,
                        style: new TextStyle(
                          color: ThemeStyle.of(context).textColorLightLarge,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      new Positioned(
                        child: new Text(
                          _news.date ?? "",
                          style:
                              new TextStyle(fontSize: 11.5, color:  ThemeStyle.of(context).textColorLightMedium),
                        ),
                        bottom: 2,
                      ),
                    ],
                  ),
                ),
              ),

              ///图片
              imageContainer,
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
        style: TextStyle(color: ThemeStyle.of(context).textColorLightMedium, fontSize: 14),
      ),
    );
  }
}
