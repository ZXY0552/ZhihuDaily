import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zhihu/commom/config/config.dart';
import 'package:zhihu/utils/shared_preferences_utlis.dart';

class ThemeStyle extends Model {
  int themeMode;

  ThemeStyleData themeStyleData;

  ThemeStyle(this.themeMode) {
    themeStyleData = new ThemeStyleData(themeMode);
  }

  int get value => themeMode;

  set value(int newValue) {
    if (themeMode == newValue) return;
    themeMode = newValue;
    themeStyleData = new ThemeStyleData(themeMode);
    notifyListeners();
  }

  static ThemeStyleData of(BuildContext context) =>
      ScopedModel.of<ThemeStyle>(context, rebuildOnChange: true).themeStyleData;

  static set(BuildContext context, int themeMode) =>
      ScopedModel.of<ThemeStyle>(context, rebuildOnChange: true).value =
          themeMode;
}

class ThemeStyleData {
  final int themeMode;
  ThemeData themeData;

  ///drawer背景色
  Color drawerBackground;

  ///drawer头
  Color drawerHeadBackground;

  ///暗色字体（日间模式下的白色）
  Color textColorDark;

  ///drawer item选择颜色
  Color drawerItemSel;

  ///分割线
  Color dividerColor;

  ///亮色主字体 （日间模式下的黑色）
  Color textColorLightLarge;

  ///亮色次字体 （日间模式下的灰色）
  Color textColorLightMedium;

  ///亮色小字体
  Color textColorLightSmall;

  ThemeStyleData(this.themeMode) {
    if (themeMode == 1) {
      themeData = ThemeData.dark();

      drawerHeadBackground = Colors.black26;
      drawerBackground = themeData.primaryColor;
      textColorDark = Color(0xFF616161);
      drawerItemSel = Colors.black12;
      textColorLightLarge = Colors.white;
      textColorLightMedium = Colors.white70;
      textColorLightSmall = Colors.white30;

      dividerColor = Colors.white10;
    } else {

      themeData = new ThemeData(primarySwatch: Colors.blue);

      drawerHeadBackground = themeData.primaryColor;
      drawerBackground = Colors.white;
      textColorDark = Colors.white;
      drawerItemSel = Color(0X10000000);
      dividerColor = new Color(0XF0B8B8B8);
      textColorLightLarge = Colors.black;
      textColorLightMedium = Colors.black54;
      textColorLightSmall = Colors.black26;
    }
  }
}
