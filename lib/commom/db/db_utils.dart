import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'db_bean.dart';

class DBUtils {
  Database _db;
  final String dbName = "zhiufu-daily-flutter.db";
  final String tableName;
  final String createSql;

  DBUtils(this.tableName, this.createSql);

  ///打开库
  Future open() async {
    if (_db == null || !_db.isOpen) {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, dbName);
      _db = await openDatabase(path,
          version: 1, onCreate: (Database db, int version) async {
            await db.execute(createSql);
          });

      var res = await _db.rawQuery(
          "select * from Sqlite_master where type = 'table' and name = '$tableName'");
      if (res == null || res.length == 0) {
        await _db.execute(createSql);
        await _db.close();
        _db = null;
        open();
      }
    }
  }

  ///修改数据 如果存在修改 不存在插入
  Future<int> set<T extends BaseDbBean>(T bean) async {
    await open();
    List<Map> maps = await _db.query(tableName,
        columns: ["id"], where: 'id = ?', whereArgs: [bean.id]);
    if (maps.length > 0) {
      int count = await _db.update(tableName, bean.toMap(),
          where: 'id = ?', whereArgs: [bean.id]);
      print("DBUtils: set 更新成功 " + count.toString());
      return count;
    } else {
      int count = await _db.insert(tableName, bean.toMap());
      print("DBUtils: set 插入成功 " + count.toString());
      return count;
    }
  }

  ///获取数据
  Future<Map> get(String key, String val, List<String> columns) async {
    await open();
    List<Map> maps = await _db.query(tableName,
        columns: columns, where: '$key = ?', whereArgs: [val]);
    if (maps.length > 0) {
      print("DBUtils:get " + maps.first.toString());
      return maps.first;
    }
    return null;
  }

  ///获取全部数据
  Future<List<Map>> getAll(List<String> columns) async {
    await open();
    List<Map> maps = await _db.query(
      tableName,
      columns: columns,
    );
    if (maps.length > 0) {
      print("DBUtils:getAll " + maps.toString());
      return maps;
    }
    return null;
  }

  Future<int> delete(
    String key,
    String val,
  ) async {
    await open();
    return await _db.delete(tableName, where: "$key = ?", whereArgs: [val]);
  }

  ///删除清理
  Future<int> deleteAll() async {
    await open();
    return await _db.delete(tableName);
  }

  Future close() async => await _db.close();
}
