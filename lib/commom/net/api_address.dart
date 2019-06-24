/// 来源 https://github.com/izzyleung/ZhihuDailyPurify/wiki/%E7%9F%A5%E4%B9%8E%E6%97%A5%E6%8A%A5-API-%E5%88%86%E6%9E%90

class ApiAddress {
  static const String host = "https://news-at.zhihu.com/api/";

  ///获取首页最新（轮播图和第一页数据 分页数据用getNewsBefore）
  static const String newsLatest = "4/news/latest";

  ///获取以前的数据
  static const String newsBefore = "4/news/before/";

  ///获取文章详情
  static const String newsDetails = "4/news/";

  ///文章的评论点赞数
  static const String newsStoryExtra = '4/story-extra/';

  ///短评论
  static String newsShortComments(String newId) =>
      '4/story/$newId/short-comments';

  ///长
  static String newsLongComments(String newId) =>
      '4/story/$newId/long-comments';
}
