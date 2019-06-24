// GENERATED CODE - DO NOT MODIFY BY HAND

part of section;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Section _$SectionFromJson(Map<String, dynamic> json) {
  return Section(
      json['thumbnail'] as String, json['name'] as String, json['id'] as int);
}

Map<String, dynamic> _$SectionToJson(Section instance) => <String, dynamic>{
      'thumbnail': instance.thumbnail,
      'name': instance.name,
      'id': instance.id
    };
