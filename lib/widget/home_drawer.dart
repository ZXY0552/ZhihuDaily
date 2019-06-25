import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeDrawerState();
  }
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.blue,
      width: MediaQuery.of(context).size.width - 58,
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Padding(padding: EdgeInsets.only(top: 36)),
          ///头像 名字
          new Row(
            children: <Widget>[
              new Padding(padding: EdgeInsets.only(left: 18)),
              new ClipOval(
                child: Image.asset(
                  "static/images/account_avatar.png",
                  width: 34,
                ),
              ),
              new Padding(padding: EdgeInsets.only(left: 12)),
              new Text(
                "请登录",
                style: new TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
          new Padding(padding: EdgeInsets.only(top: 16)),

          ///收藏 离线
          new Row(
            children: <Widget>[
              new Expanded(
                  child: new FlatButton.icon(
                      onPressed: () {
                        Fluttertoast.showToast(msg: "没写");
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      label: new Text(
                        "我的收藏",
                        style: new TextStyle(color: Colors.white, fontSize: 14),
                      ))),
              new Expanded(
                  child: new FlatButton.icon(
                      onPressed: () {
                        Fluttertoast.showToast(msg: "也没写");
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_downward,
                        color: Colors.white,
                      ),
                      label: new Text(
                        "离线下载",
                        style: new TextStyle(color: Colors.white, fontSize: 14),
                      ))),
            ],
          ),

          ///列表
          ///主题日报列表接口已不返回数据 固定死只有一个主页
          new Expanded(
            child: new Container(
              color: Colors.white,
              //child: new ListView(),
              child: new Column(
                children: <Widget>[
                  new InkWell(
                    onTap: (){Navigator.pop(context);},
                    child: new Container(
                      color: Color(0X10000000),
                      padding: EdgeInsets.only(left: 18, top: 14, bottom: 14),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Icon(
                            Icons.home,
                            color: Colors.blue,
                          ),
                          new Padding(padding: EdgeInsets.only(left: 10)),
                          new Text(
                            "首页",
                            style:
                                new TextStyle(color: Colors.blue, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
