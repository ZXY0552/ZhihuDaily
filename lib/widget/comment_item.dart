import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zhihu/commom/model/comment.dart';
import 'package:zhihu/commom/style/theme_style.dart';
import 'package:zhihu/utils/date_utils.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem({Key key, this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {
        showAlertDialog(context, comment.content);
      },
      child: new Container(
        padding: EdgeInsets.all(14),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///头像
            new ClipOval(
              child: new CachedNetworkImage(
                imageUrl: comment.avatar,
                width: 40,
              ),
            ),
            new Padding(padding: EdgeInsets.only(left: 12)),
            new Expanded(
                child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ///名字
                    new Expanded(
                        child: new Text(
                      comment.author,
                      style: TextStyle(
                        color: ThemeStyle.of(context).textColorLightLarge,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )),

                    ///点赞数
                    Image.asset("static/images/praise.png",
                        width: 17,
                        color: ThemeStyle.of(context).textColorLightSmall),
                    new Padding(padding: EdgeInsets.only(left: 4)),
                    new Text(
                      comment.likes.toString(),
                      style: TextStyle(
                          color: ThemeStyle.of(context).textColorLightSmall,
                          fontSize: 14),
                    ),
                  ],
                ),
                new Padding(padding: EdgeInsets.only(top: 10)),

                ///评论内容
                new CommentContext(
                  comment: comment,
                ),
                new Padding(padding: EdgeInsets.only(top: 12)),

                ///时间
                new Text(
                  DateUtils.formatTimeToStr(comment.time),
                  style: TextStyle(
                      color: ThemeStyle.of(context).textColorLightSmall,
                      fontSize: 13.5),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class CommentContext extends StatelessWidget {
  final Comment comment;

  const CommentContext({Key key, this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = new List();

    ///评论内容
    textSpans.add(new TextSpan(
        text: comment.content,
        style: TextStyle(
            color: ThemeStyle.of(context).textColorLightMedium,
            fontSize: 15.5)));

    ///所回复的消息
    if (comment.replyTo != null) {
      ///原消息作者
      textSpans.add(new TextSpan(
          text: "\n//${comment.replyTo.author} : ",
          style: TextStyle(
              color: ThemeStyle.of(context).textColorLightLarge,
              fontWeight: FontWeight.bold,
              fontSize: 15.5)));

      ///原消息内容
      textSpans.add(new TextSpan(
          text: comment.replyTo.content,
          style: TextStyle(
              color: ThemeStyle.of(context).textColorLightSmall,
              fontSize: 15.5)));
    }

    return Text.rich(new TextSpan(children: textSpans));
  }
}

void showAlertDialog(BuildContext context, String content) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          child: new Container(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(padding: EdgeInsets.only(top: 10)),
                new _DialogMenuItem(
                  title: "赞同",
                ),
                new _DialogMenuItem(
                  title: "举报",
                ),
                new _DialogMenuItem(
                  title: "复制",
                  content: content,
                ),
                new _DialogMenuItem(
                  title: "回复",
                ),
                new Padding(padding: EdgeInsets.only(bottom: 10)),
              ],
            ),
          ),
        );
      });
}

class _DialogMenuItem extends StatelessWidget {
  final String title;
  final String content;

  const _DialogMenuItem({Key key, this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (title == "复制") {
            ClipboardData data = new ClipboardData(text: content);
            Clipboard.setData(data);
            Fluttertoast.showToast(msg: "复制成功");
          } else {
            Fluttertoast.showToast(msg: "假的不能点，没有账号相关的接口");
          }
          Navigator.of(context).pop();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 26, right: 26, top: 16, bottom: 16),
          child: new Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 15),
          ),
        ));
  }
}
