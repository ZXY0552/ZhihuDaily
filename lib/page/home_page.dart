import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zhihu/commom/config/config.dart';
import 'package:zhihu/commom/model/latest.dart';
import 'package:zhihu/commom/model/news.dart';
import 'package:zhihu/commom/net/api.dart';
import 'package:zhihu/commom/net/api_address.dart';
import 'package:zhihu/commom/router.dart';
import 'package:zhihu/commom/style/theme_style.dart';
import 'package:zhihu/utils/date_utils.dart';
import 'package:zhihu/utils/shared_preferences_utlis.dart';
import 'package:zhihu/widget/bar_icon_actions.dart';
import 'package:zhihu/widget/home_drawer.dart';
import 'package:zhihu/widget/news_item.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text(
          "首页",
          style: new TextStyle(fontSize: 18),
        ),
        actions: <Widget>[
          new AppBarIcoAction(
            icon: new Icon(Icons.notifications),
          ),
          new PopupMenuButton(
            onSelected: (String value) {
              if (value == "夜间模式") {
                if (ThemeStyle.of(context).themeMode == 1) {
                  ThemeStyle.set(context, 0);
                  SharedPreferencesUtils.save(Config.SP_THEME_MODE, 0);
                } else {
                  ThemeStyle.set(context, 1);
                  SharedPreferencesUtils.save(Config.SP_THEME_MODE, 1);
                }
              } else {
                Fluttertoast.showToast(msg: "还没写");
              }
            },
            itemBuilder: (context) {
              return <PopupMenuItem<String>>[
                new PopupMenuItem<String>(
                  value: "夜间模式",
                  child: new Container(
                    height: 32,
                    width: 96,
                    child: new Text(ThemeStyle.of(context).themeMode == 1
                        ? "日间模式"
                        : "夜间模式"),
                  ),
                ),
                new PopupMenuItem<String>(
                  value: "设置选项",
                  child: new Container(
                    height: 32,
                    width: 96,
                    child: new Text("设置选项"),
                  ),
                ),
              ];
            },
            child: new InkWell(
              child: new Container(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: new Icon(Icons.more_vert),
              ),
            ),
          ),
        ],
      ),
      drawer: new HomeDrawer(),
      body: new HomePageList(),
    );
  }
}

class HomePageList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageListState();
}

class _HomePageListState extends State<HomePageList> {
  ///列表
  List<News> _stories = new List();

  ///轮播图
  List<News> _topStories = new List();

  bool isLoading = false;

  String _beforeTime;
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
    _onRefresh();
  }

  ///刷新
  Future<Null> _onRefresh() async {
    if (isLoading) {
      return null;
    }

    isLoading = true;
    if (_stories.isNotEmpty) {
      ///不为空 说明是下拉刷新
      ///延迟一秒 网速太快 下拉刷新框缩回去太快了
      await Future.delayed(Duration(seconds: 1));
    }
    httpManager.get(ApiAddress.newsLatest, (data) {
      LatestNews latestNews = LatestNews.fromJson(data);
      setState(() {
        isLoading = false;
        _stories.clear();
        _topStories.clear();

        _beforeTime = latestNews.date;
        _topStories = latestNews.top_stories;
        _stories.add(News.ofTimeTitle("今日要闻"));
        _stories.addAll(latestNews.stories);

        ///当前列表数量小于6  可能不够一屏 所以加载下一页，不然无法刷新和监听滑到底部
        if (_stories.length < 6) {
          _onNextPage();
        }
      });
    });
    return null;
  }

  ///下一页
  _onNextPage() {
    if (isLoading) {
      return;
    }
    isLoading = true;
    httpManager.get(ApiAddress.newsBefore + _beforeTime, (data) {
      LatestNews latestNews = LatestNews.fromJson(data);
      setState(() {
        isLoading = false;
        _beforeTime = latestNews.date;
        _stories.add(News.ofTimeTitle(DateUtils.formatTimeTitle(_beforeTime)));
        _stories.addAll(latestNews.stories);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool topStoriesIsEmpty = _topStories.isEmpty;
    return new RefreshIndicator(
      onRefresh: _onRefresh,
      child: new ListView.builder(
        controller: _controller,
        itemBuilder: (context, index) {
          final double width = MediaQuery.of(context).size.width;

          ///下标为0 并且轮播图不为空 显示轮播图
          if (index == 0 && !topStoriesIsEmpty) {
            ///轮播图
            return new Container(
                width: width,
                height: width * 2 / 3,
                child: new Swiper(
                  itemBuilder: (context, index) {
                    return new Stack(
                      children: <Widget>[
                        ///图片
                        new Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            right: 0,
                            child: Image.network(
                              _topStories[index].image,
                              fit: BoxFit.fitWidth,
                            )),

                        ///阴影
                        new Positioned(
                          left: 0,
                          top: width * 2 / 3 / 2,
                          bottom: 0,
                          right: 0,
                          child: new Container(
                              decoration: new BoxDecoration(
                                  gradient: LinearGradient(
                            colors: [Colors.transparent, Color(0xA6000000)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ))),
                        ),

                        ///标题
                        new Positioned(
                            left: 12,
                            right: 12,
                            bottom: 32,
                            child: new Text(
                              _topStories[index].title,
                              maxLines: 2,
                              style: new TextStyle(
                                fontSize: 21,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    );
                  },
                  itemCount: _topStories.length,
                  pagination: new SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                    color: Colors.grey,
                    size: 7,
                    activeSize: 7,
                    activeColor: Colors.white,
                  )),
                  scrollDirection: Axis.horizontal,
                  autoplay: !topStoriesIsEmpty,
                  autoplayDelay: 5000,
                  onTap: (index) {
                    Router.push(
                        context, Router.NewsDetails, _topStories[index].id);
                  },
                ));
          }

          ///轮播图不为空 取数据要减去轮播图
          final storiesIndex = topStoriesIsEmpty ? index : index - 1;
          final News news = _stories[storiesIndex];
          if (news.id == null) {
            return new TimeTitleWidget(news.title);
          } else {
            return new NewsItemWidget(news);
          }
        },
        itemCount: _stories.length + (topStoriesIsEmpty ? 0 : 1),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
