import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppBarIcoAction extends StatelessWidget {
  final GestureTapCallback callback;
  final Widget icon;
  final String labelText;

  const AppBarIcoAction({Key key, this.callback, this.icon, this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: callback ??
          () {
            Fluttertoast.showToast(msg: "假的不能点，没有账号相关的接口");
          },
      child: new Container(
          padding: labelText == null
              ? EdgeInsets.only(left: 12, right: 12)
              : EdgeInsets.only(left: 12),
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              icon,
              new Padding(
                  padding: labelText == null
                      ? EdgeInsets.all(0)
                      : EdgeInsets.only(left: 6)),
              new Text(
                labelText == null ? "" : labelText,
                style: new TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    wordSpacing: 0,
                    letterSpacing: 0),
              )
            ],
          )),
    );
  }
}
