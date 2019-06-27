library newsdetails;

import 'package:json_annotation/json_annotation.dart';
import 'package:zhihu/commom/model/section.dart';

part 'news_details.g.dart';

@JsonSerializable()
class NewsDetails {
  factory NewsDetails.fromJson(Map<String, dynamic> json) =>
      _$NewsDetailsFromJson(json);

  Map<String, dynamic> toJson(NewsDetails instance) =>
      _$NewsDetailsToJson(instance);

  String body;

  ///背景图来源
  @JsonKey(name: "image_source")
  String imageSource;
  String title;

  List<String> images;
  ///封面背景图
  String image;
  @JsonKey(name: "share_url")
  String shareUrl;
  int id;

  ///所属分类
  Section section;

  ///样式
  List<String> css;

  NewsDetails(this.body, this.imageSource, this.title, this.images, this.image,
      this.shareUrl, this.id, this.section, this.css);

}
