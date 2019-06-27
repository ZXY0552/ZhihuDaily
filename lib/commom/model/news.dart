library news;

import 'package:json_annotation/json_annotation.dart';
import 'package:zhihu/commom/db/collect_db.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  Map<String, dynamic> toJson(News instance) => _$NewsToJson(instance);

  String title;
  int id;
  String image;
  List<String> images;
  @JsonKey(name: "display_date")
  String date;

  ///是否多图
  bool multipic;

  News.ofTimeTitle(this.title);

  News(this.title, this.id, this.image, this.images, this.date, this.multipic);

  News.ofCollect(CollectData collectData) {
    title = collectData.title;
    id = collectData.id;
    images = [collectData.images];
  }

}
