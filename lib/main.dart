import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zhihu/commom/style/theme_style.dart';
import 'package:zhihu/page/home_page.dart';
import 'package:zhihu/utils/shared_preferences_utlis.dart';

import 'commom/config/config.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int themeMode;
  ThemeStyle themeStyle;

  @override
  void initState() {
    super.initState();
    getThemeMode();
  }

  getThemeMode() async {
    themeMode = await SharedPreferencesUtils.get(Config.SP_THEME_MODE);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    themeStyle = new ThemeStyle(themeMode);
    return new ScopedModel<ThemeStyle>(
      model: themeStyle,
      child: new ScopedModelDescendant<ThemeStyle>(
          builder: (context, child, model) {
        return new MaterialApp(
          theme: model.themeStyleData.themeData,
          home: new HomePage(),
        );
      }),
    );
  }
}
