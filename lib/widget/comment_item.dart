import 'package:flutter/material.dart';
import 'package:zhihu/commom/model/comment.dart';
import 'package:zhihu/utils/date_utils.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem({Key key, this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {},
      child: new Container(
        padding: EdgeInsets.all(14),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///头像
            new ClipOval(
                child: Image.network(
              comment.avatar,
              width: 40,
            )),
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
                        color: Color(0XFF171717),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )),

                    ///点赞数
                    Image.asset("static/images/praise.png",
                        width: 17, color: Color(0XFFB8B8B8)),
                    new Padding(padding: EdgeInsets.only(left: 4)),
                    new Text(
                      comment.likes.toString(),
                      style: TextStyle(color: Color(0XFFBDBDBD), fontSize: 14),
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
                  style: TextStyle(color: Color(0XFFBABABA), fontSize: 13.5),
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
        style: TextStyle(color: Color(0XFF1D1D1D), fontSize: 15.5)));

    ///所回复的消息
    if (comment.replyTo != null) {
      ///原消息作者
      textSpans.add(new TextSpan(
          text: "\n//${comment.replyTo.author} : ",
          style: TextStyle(
              color: Color(0XFF171717),
              fontWeight: FontWeight.bold,
              fontSize: 15.5)));

      ///原消息内容
      textSpans.add(new TextSpan(
          text: comment.replyTo.content,
          style: TextStyle(color: Color(0XFF777777), fontSize: 15.5)));
    }

    return Text.rich(new TextSpan(children: textSpans));
  }
}
