library commentlist;

import 'package:json_annotation/json_annotation.dart';
import 'comment.dart';

part 'comment_list.g.dart';

@JsonSerializable()
class CommentList {
  factory CommentList.fromJson(Map<String, dynamic> json) =>
      _$CommentListFromJson(json);

  Map<String, dynamic> toJson(CommentList instance) =>
      _$CommentListToJson(instance);

  List<Comment> comments;

  CommentList(this.comments);
}
