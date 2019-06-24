library comment;

import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson(Comment instance) => _$CommentToJson(instance);

  String author;
  String content;
  String avatar;
  int time;
  int id;
  int likes;
  @JsonKey(name: "reply_to")
  Comment replyTo;

  Comment(this.author, this.content, this.avatar, this.time, this.id,
      this.likes, this.replyTo);
}
