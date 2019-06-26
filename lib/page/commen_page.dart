import 'package:flutter/material.dart';
import 'package:zhihu/commom/model/comment.dart';
import 'package:zhihu/commom/model/comment_list.dart';
import 'package:zhihu/commom/net/api.dart';
import 'package:zhihu/commom/net/api_address.dart';
import 'package:zhihu/commom/style/theme_style.dart';
import 'package:zhihu/widget/bar_icon_actions.dart';
import 'package:zhihu/widget/comment_item.dart';

///评论页面
class CommentPage extends StatefulWidget {
  final int newsId;
  final String comments;

  const CommentPage({Key key, this.newsId, this.comments}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _CommentPageState();
  }
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> shortComments = new List();
  List<Comment> longComments = new List();

  ///短评论展开关闭
  ValueNotifier<bool> shortCommentsVisible = new ValueNotifier(true);
  ScrollController _scrollController;

  GlobalKey _shortCommentsTitleKey = GlobalKey();

  ///短评论展开关闭监听
  _shortCommentsVisibleChange() {
    setState(() {
      if (shortCommentsVisible.value) {
        ///关闭的话滑动到顶部
        _scrollController.animateTo(0,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      } else {
        ///展开的话滑动到短评论

        RenderBox box =
            _shortCommentsTitleKey.currentContext.findRenderObject();
        Offset offset = box.localToGlobal(Offset.zero);
        Size size = box.size;

        ///滑动的位置等于 当前滑动的位置（这个是相对于父组件的位置） 加上当前短评论的title离AppBar的距离
        ///当前短评论的title离AppBar的距离 等于短评论的title的底部距离（相对于屏幕）- 短评论的titl的高度 在 -AppBar的高度
        ///最后加上 通栏的高度

        double offsetPosition = _scrollController.position.pixels +
            offset.dy -
            size.height -
            MediaQuery.of(context).padding.top;

        _scrollController.animateTo(offsetPosition,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    shortCommentsVisible.addListener(_shortCommentsVisibleChange);
    _scrollController = new ScrollController();
    httpManager.get(ApiAddress.newsLongComments(widget.newsId.toString()),
        (data) {
      setState(() {
        longComments = CommentList.fromJson(data).comments;
      });
    });

    httpManager.get(ApiAddress.newsShortComments(widget.newsId.toString()),
        (data) {
      setState(() {
        shortComments = CommentList.fromJson(data).comments;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    shortCommentsVisible.removeListener(_shortCommentsVisibleChange);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new _TitleBarTitle(comments: widget.comments),
          actions: <Widget>[
            new AppBarIcoAction(
              icon: Image.asset("static/images/comment_write.png", width: 26),
            ),
          ]),
      body: new SingleChildScrollView(
        controller: _scrollController,
        child: new Column(
          children: <Widget>[
            ///长评论数量
            new Divider(
              height: 1,
              color: ThemeStyle.of(context).dividerColor,
            ),
            new Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              child: new Text(
                "${longComments.length} 条长评论",
                style: TextStyle(
                    color: ThemeStyle.of(context).textColorLightMedium),
                textAlign: TextAlign.start,
              ),
            ),
            new Divider(
              height: 1,
              color: ThemeStyle.of(context).dividerColor,
            ),

            ///长评论列表
            new _CommentList(
              comments: longComments,
            ),
            new Offstage(
              child: new Container(
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height * 4,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "static/images/dark_comment_empty.png",
                      color: Color(0XFFE4E4E4),
                      width: 182,
                    ),
                    new Text(
                      "深度长评虚位以待",
                      style:
                          new TextStyle(fontSize: 14, color: Color(0XFFE4E4E4)),
                    )
                  ],
                ),
              ),
              offstage: longComments.length > 0,
            ),

            ///短评论数量
            new Divider(
              height: 1,
              color: ThemeStyle.of(context).dividerColor,
            ),
            new GestureDetector(
              key: _shortCommentsTitleKey,
              onTap: () {
                shortCommentsVisible.value = !shortCommentsVisible.value;
              },
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: Container(
                    padding: EdgeInsets.all(16),
                    child: new Text(
                      "${shortComments.length} 条短评论",
                      style: TextStyle(
                        color: ThemeStyle.of(context).textColorLightMedium,
                      ),
                    ),
                  )),
                  new Icon(
                      shortCommentsVisible.value
                          ? Icons.expand_more
                          : Icons.expand_less,
                      color: Color(0XFFB8B8B8)),
                  new Padding(padding: EdgeInsets.only(right: 12))
                ],
              ),
            ),
            new Divider(
              height: 1,
              color: ThemeStyle.of(context).dividerColor,
            ),

            ///短评论列表
            new Offstage(
              child: _CommentList(
                comments: shortComments,
              ),
              offstage: shortCommentsVisible.value,
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleBarTitle extends StatelessWidget {
  final String comments;

  const _TitleBarTitle({Key key, this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      new TextSpan(children: [
        new TextSpan(
            text: "$comments",
            style: new TextStyle(
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        new TextSpan(
            text: "  条评论",
            style: new TextStyle(
              fontSize: 16,
              color: Color(0xE6FFFFFF),
            )),
      ]),
    );
  }
}

class _CommentList extends StatelessWidget {
  final List<Comment> comments;

  const _CommentList({Key key, this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> items = new List();
    comments.forEach((_comment) {
      items.add(new CommentItem(
        comment: _comment,
      ));
    });

    ///添加分割线
    var divideListItem = ListTile.divideTiles(
      tiles: items,
      context: context,
      color: ThemeStyle.of(context).dividerColor,
    ).toList();
    return new ListView(
      shrinkWrap: true,
      physics: new NeverScrollableScrollPhysics(),
      children: divideListItem,
    );
  }
}
