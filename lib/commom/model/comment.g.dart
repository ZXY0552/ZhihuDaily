// GENERATED CODE - DO NOT MODIFY BY HAND

part of comment;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
      json['author'] as String,
      json['content'] as String,
      json['avatar'] as String,
      json['time'] as int,
      json['id'] as int,
      json['likes'] as int,
      json['reply_to'] == null
          ? null
          : Comment.fromJson(json['reply_to'] as Map<String, dynamic>));
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'author': instance.author,
      'content': instance.content,
      'avatar': instance.avatar,
      'time': instance.time,
      'id': instance.id,
      'likes': instance.likes,
      'reply_to': instance.replyTo
    };
