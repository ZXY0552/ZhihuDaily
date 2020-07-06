import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zhihu/commom/router.dart';
import 'package:zhihu/commom/style/theme_style.dart';

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
      color: ThemeStyle.of(context).drawerBackground,
      width: MediaQuery.of(context).size.width - 58,
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ///头
          new Container(
            color: ThemeStyle.of(context).drawerHeadBackground,
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
                      style: new TextStyle(
                        color: ThemeStyle.of(context).textColorDark,
                        fontSize: 15,
                      ),
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
                              Navigator.pop(context);
                              Router().pushNoParams(context, Router.CollectList);
                            },
                            icon: Icon(
                              Icons.star,
                              color: Colors.white,
                            ),
                            label: new Text(
                              "我的收藏",
                              style: new TextStyle(
                                color: ThemeStyle.of(context).textColorDark,
                                fontSize: 14,
                              ),
                            ))),
                    new Expanded(
                        child: new FlatButton.icon(
                            onPressed: () {
                              Fluttertoast.showToast(msg: "没写");
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            ),
                            label: new Text(
                              "离线下载",
                              style: new TextStyle(
                                color: ThemeStyle.of(context).textColorDark,
                                fontSize: 14,
                              ),
                            ))),
                  ],
                ),
              ],
            ),
          ),

          ///列表
          ///主题日报列表接口已不返回数据 固定死只有一个主页
          new Expanded(
            child: new Container(
              color: ThemeStyle.of(context).drawerBackground,
              //child: new ListView(),
              child: new Column(
                children: <Widget>[
                  new InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: new Container(
                      color: ThemeStyle.of(context).drawerItemSel,
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
