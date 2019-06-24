library newsstoryextra;

import 'package:json_annotation/json_annotation.dart';

part 'news_story_extra.g.dart';

@JsonSerializable()
class NewsStoryExtra {
    factory NewsStoryExtra.fromJson(Map<String, dynamic> json) => _$NewsStoryExtraFromJson(json);

     Map<String, dynamic> toJson(NewsStoryExtra instance) => _$NewsStoryExtraToJson(instance);

  ///长评论总数
  @JsonKey(name: "long_comments")
  int longComments;

  /// 点赞总数
  int popularity;

  ///评论总数
  int comments;

  ///短评论总数
  @JsonKey(name: "short_comments")
  int shortComments;

  NewsStoryExtra(this.longComments, this.popularity, this.comments,
      this.shortComments);

}
