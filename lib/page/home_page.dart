import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:zhihu/commom/model/latest.dart';
import 'package:zhihu/commom/model/news.dart';
import 'package:zhihu/commom/net/api.dart';
import 'package:zhihu/commom/net/api_address.dart';
import 'package:zhihu/commom/router.dart';
import 'package:zhihu/utils/date_utils.dart';
import 'package:zhihu/widget/news_item.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("首页"),
      ),
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
          ///下标为0 并且轮播图不为空 显示轮播图
          if (index == 0 && !topStoriesIsEmpty) {
            ///轮播图
            return new Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 2 / 3,
                child: Swiper(
                  itemBuilder: (context, index) {
                    return new Image.network(
                      _topStories[index].image,
                      fit: BoxFit.fitWidth,
                    );
                  },
                  itemCount: _topStories.length,
                  pagination: new SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                    color: Colors.black38,
                    size: 8,
                    activeSize: 8,
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
