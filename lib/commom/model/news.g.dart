// GENERATED CODE - DO NOT MODIFY BY HAND

part of news;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) {
  return News(
      json['title'] as String,
      json['type'] as int,
      json['id'] as int,
      json['image'] as String,
      (json['images'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'title': instance.title,
      'type': instance.type,
      'id': instance.id,
      'image': instance.image,
      'images': instance.images
    };
