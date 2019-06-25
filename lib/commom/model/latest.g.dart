// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatestNews _$LatestNewsFromJson(Map<String, dynamic> json) {
  return LatestNews(
      json['date'] as String,
      json['timestamp'] as int,
      json['name'] as String,
      (json['stories'] as List)
          ?.map((e) =>
              e == null ? null : News.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['top_stories'] as List)
          ?.map((e) =>
              e == null ? null : News.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$LatestNewsToJson(LatestNews instance) =>
    <String, dynamic>{
      'date': instance.date,
      'timestamp': instance.timestamp,
      'stories': instance.stories,
      'name': instance.name,
      'top_stories': instance.top_stories
    };
