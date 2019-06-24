library news;

import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  Map<String, dynamic> toJson(News instance) => _$NewsToJson(instance);

  String title;
  int type;
  int id;
  String image;
  List<String> images;

  News.ofTimeTitle(this.title);

  News(this.title, this.type, this.id, this.image, this.images);
}
