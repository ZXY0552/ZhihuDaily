// GENERATED CODE - DO NOT MODIFY BY HAND

part of commentlist;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentList _$CommentListFromJson(Map<String, dynamic> json) {
  return CommentList((json['comments'] as List)
      ?.map(
          (e) => e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$CommentListToJson(CommentList instance) =>
    <String, dynamic>{'comments': instance.comments};
