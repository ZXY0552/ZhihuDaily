import 'news.dart';

import 'package:json_annotation/json_annotation.dart';

part 'latest.g.dart';

///首页最新消息
@JsonSerializable()
class LatestNews {
  factory LatestNews.fromJson(Map<String, dynamic> json) =>
      _$LatestNewsFromJson(json);

  Map<String, dynamic> toJson(LatestNews instance) =>
      _$LatestNewsToJson(instance);

  String date;
  int timestamp;
  String name;

  ///列表
  List<News> stories;

  ///轮播图
  List<News> top_stories;

  LatestNews(this.date, this.timestamp, this.name, this.stories,
      this.top_stories);


}
