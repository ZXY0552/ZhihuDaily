import 'package:zhihu/commom/model/news.dart';
import 'package:zhihu/commom/model/news_details.dart';

import 'db_bean.dart';
import 'db_utils.dart';

final String tableName = "table_collect";
final String newsIdTag = "id";
final String newsTitleTag = "title";
final String newsImagesTag = "images";

class CollectData extends BaseDbBean {
  String title;
  String images;

  CollectData({this.title, this.images});

  CollectData.formNews(News news) {
    id = news.id;
    title = news.title;
    if (news.images != null && news.images.length > 0) {
      images = news.images[0];
    } else {
      images = "";
    }
  }

  CollectData.formNewsDetails(NewsDetails newsDetails) {
    id = newsDetails.id;
    title = newsDetails.title;
    if (newsDetails.images != null && newsDetails.images.length > 0) {
      images = newsDetails.images[0];
    } else {
      images = "";
    }
  }

  @override
  List<String> toKeyList() {
    return [newsIdTag, newsTitleTag, newsImagesTag];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      newsIdTag: id,
      newsTitleTag: title,
      newsImagesTag: images
    };
    return map;
  }

  CollectData.fromMap(Map<String, dynamic> map) {
    id = map[newsIdTag];
    images = map[newsImagesTag];
    title = map[newsTitleTag];
  }
}

class CollectDb {
  DBUtils _database;
  final String createSql = '''
  create table $tableName ( 
  columnId integer primary key autoincrement, 
  $newsIdTag integer,
  $newsTitleTag text,
  $newsImagesTag text)''';

  CollectDb() {
    _database = new DBUtils(tableName, createSql);
    _database.open();
  }

  Future<CollectData> get(int newsId) async {
    CollectData cacheBean = new CollectData();
    Map<String, dynamic> map = await _database.get(
        newsIdTag, newsId.toString(), cacheBean.toKeyList());
    if (map != null) {
      return cacheBean = CollectData.fromMap(map);
    } else {
      return null;
    }
  }

  Future<List<News>> getAll() async {
    CollectData cacheBean = new CollectData();
    List<Map<String, dynamic>> map =
        await _database.getAll(cacheBean.toKeyList());
    if (map != null && map.length > 0) {
      List<News> newsList = new List();
      map.forEach((mapData) {
        CollectData collectData = CollectData.fromMap(mapData);
        newsList.add(News.ofCollect(collectData));
      });
      return newsList;
    } else {
      return null;
    }
  }

  Future<int> set(CollectData collectData) async {
    return await _database.set(collectData);
  }

  Future<int> delete(int id) async {
    return await _database.delete(newsIdTag, id.toString());
  }

  close() async {
    await _database.close();
  }
}
