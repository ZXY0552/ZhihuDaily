import 'db_bean.dart';
import 'db_utils.dart';

final String tableName = "table_cache";
final String cacheId = "id";
final String cacheKey = "key";
final String cacheVal = "val";

class CacheData extends BaseDbBean {
  String key;
  String val;

  CacheData({this.key, this.val}) : super(id: key.hashCode);

  CacheData.fromMap(Map<String, dynamic> map) {
    key = map[cacheKey];
    val = map[cacheVal];
  }

  @override
  List<String> toKeyList() {
    return [cacheId, cacheKey, cacheVal];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      cacheKey: key,
      cacheVal: val,
    };
    if (id != null) {
      map[cacheId] = this.id;
    }
    return map;
  }
}

class CacheDb {
  DBUtils _database;
  final String createSql = '''
  create table $tableName ( 
  columnId integer primary key autoincrement, 
  id integer not null,
  $cacheKey text not null,
  $cacheVal text )''';

  CacheDb() {
    _database = new DBUtils(tableName, createSql);
    _database.open();
  }

  Future<CacheData> get(int urlHashCode) async {
    CacheData cacheBean = new CacheData();
    Map<String, dynamic> map = await _database.get(
        cacheId, urlHashCode.toString(), cacheBean.toKeyList());
    if (map != null) {
      return cacheBean = CacheData.fromMap(map);
    } else {
      return null;
    }
  }

  set(CacheData cacheBean) async {
    await _database.set(cacheBean);
  }


  clear() async{
    await _database.deleteAll();
  }
}
