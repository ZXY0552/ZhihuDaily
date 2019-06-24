import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileUtils {

  ///获取本地文件
  static Future<File> getLocalFile(String fileName) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/$fileName');
  }

  ///检查文件是否存在 不存在创建
  static Future<File> checkFile(String fileName) async {
    File file = await getLocalFile(fileName);
    bool isExist = await file.exists();
    int fileLength = isExist ? await file.length() : -1;
    if (!isExist || fileLength <= 0) {
      if (isExist) {
        await file.delete();
      }
      await file.create();
    }
    return file;
  }

  ///保存html文件
  static Future<String> writeHtmlDataFile(String data, String fileName) async {
    File file = await  checkFile(fileName);
    File afterFile = await file.writeAsString(data);
    return afterFile.uri.toString();
  }
}
