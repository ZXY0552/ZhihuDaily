// GENERATED CODE - DO NOT MODIFY BY HAND

part of newsdetails;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsDetails _$NewsDetailsFromJson(Map<String, dynamic> json) {
  return NewsDetails(
      json['body'] as String,
      json['image_source'] as String,
      json['title'] as String,
      json['image'] as String,
      json['share_url'] as String,
      json['id'] as int,
      json['section'] == null
          ? null
          : Section.fromJson(json['section'] as Map<String, dynamic>),
      (json['css'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$NewsDetailsToJson(NewsDetails instance) =>
    <String, dynamic>{
      'body': instance.body,
      'image_source': instance.imageSource,
      'title': instance.title,
      'image': instance.image,
      'share_url': instance.shareUrl,
      'id': instance.id,
      'section': instance.section,
      'css': instance.css
    };
