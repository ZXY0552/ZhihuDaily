import 'dart:convert';

import 'package:zhihu/utils/date_utils.dart';

void main() {
  Uri uri =
      new Uri(path: "app://section", queryParameters: {"sectionId": "标题"});
  String URL = uri.toString();
  print(URL);

  Utf8Decoder utf8decoder = new Utf8Decoder();

}
