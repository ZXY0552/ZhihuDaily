// GENERATED CODE - DO NOT MODIFY BY HAND

part of newsstoryextra;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsStoryExtra _$NewsStoryExtraFromJson(Map<String, dynamic> json) {
  return NewsStoryExtra(json['long_comments'] as int, json['popularity'] as int,
      json['comments'] as int, json['short_comments'] as int);
}

Map<String, dynamic> _$NewsStoryExtraToJson(NewsStoryExtra instance) =>
    <String, dynamic>{
      'long_comments': instance.longComments,
      'popularity': instance.popularity,
      'comments': instance.comments,
      'short_comments': instance.shortComments
    };
