import 'package:quiver/cache.dart';

import 'db/cache_db.dart';

///缓存管理
class CacheManger {
  ///内存缓存
  MapCache<String, String> _cacheMap = MapCache();

  ///数据库缓存
  CacheDb _cacheDb;

  static final CacheManger _singleton = CacheManger._internal();

  factory CacheManger() {
    return _singleton;
  }

  CacheManger._internal() {
    _cacheDb = new CacheDb();
  }

  Future<String> get(String key) async {
    String cacheMapData = await _cacheMap.get(key);

    ///内存没有
    if (cacheMapData == null) {
      CacheData cacheData = await _cacheDb.get(key.hashCode);

      ///取数据库
      if (cacheData != null) {
        _cacheMap.set(key, cacheData.val);
        return cacheData.val;
      } else {
        return null;
      }
    } else {
      return _cacheMap.get(key);
    }
  }

  set(String key, String value) async {
    _cacheMap.set(key, value);
    return _cacheDb.set(CacheData(key: key, val: value));
  }

  ///清理
  clear() async {
    await _cacheDb.clear();
    _cacheMap = MapCache.lru();
  }
}
