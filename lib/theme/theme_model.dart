import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/config/constant.dart';
import 'package:flutter_start/generated/l10n.dart';

class ThemeModel extends ChangeNotifier {
  static const kThemeColorIndex = 'kThemeColorIndex';
  static const kThemeUserDarkMode = 'kThemeUserDarkMode';
  static const kFontFamily = 'kFontFamily';

  /// 明暗模式
  late int _darkModeIndex;

  /// 当前主题颜色
  late MaterialColor _themeColor;

  /// 当前字体
  late String _fontFamily;

  ThemeModel() {
    _darkModeIndex = SpUtil.getInt(kThemeUserDarkMode)!;
    _themeColor = ConstantUtil.themeColorSupport.keys
        .toList()[SpUtil.getInt(kThemeColorIndex)!];
    _fontFamily = SpUtil.getString(kFontFamily, defValue: 'system')!;
  }

  String get fontFamily => _fontFamily;
  MaterialColor get themeColor => _themeColor;
  int get darkModeIndex => _darkModeIndex;

  void switchDarkMode(int? index) {
    _darkModeIndex = index ?? _darkModeIndex;
    notifyListeners();
    _saveDarkMode2Storage(_darkModeIndex);
  }

  /// 切换指定色彩
  ///
  /// 没有传[brightness]就不改变brightness,color同理
  void switchTheme({MaterialColor? color}) {
    _themeColor = color ?? _themeColor;
    notifyListeners();
    _saveColor2Storage(_themeColor);
  }

  /// 切换字体
  void switchFontFamily({required String fontFamily}) {
    _fontFamily = fontFamily;
    notifyListeners();
    _saveFontFamily2Storage(_fontFamily);
  }

  ThemeMode getThemeMode() {
    int index = SpUtil.getInt(kThemeUserDarkMode)!;
    switch (index) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      default:
        return ThemeMode.dark;
    }
  }

  /// 自定义 themeData
  /// isPlatformDarkMode: 系统级别
  ThemeData themeData({bool isDarkMode: false}) {
    var themeColor = _themeColor;

    ///
    return ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,

        /// 主色
        primaryColor: isDarkMode ? themeColor[700] : themeColor,

        /// 次级色
        accentColor: isDarkMode ? themeColor[800] : _themeColor,

        /// 自定义 tabbar
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: isDarkMode ? Colors.grey[800]! : Colors.white,
          selectedItemColor: isDarkMode ? themeColor[700] : themeColor,
          unselectedItemColor: isDarkMode ? Colors.white70 : Colors.black54,
          selectedLabelStyle: TextStyle(
              color: isDarkMode ? themeColor[700] : themeColor,
              fontSize: 14,
              fontFamily: _fontFamily),
          unselectedLabelStyle: TextStyle(
              color: isDarkMode ? Colors.white70 : Colors.black54,
              fontSize: 12),
        ),

        /// 导航条
        appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 0.0,
            color: isDarkMode ? Colors.grey[900]! : themeColor,
            brightness: isDarkMode ? Brightness.dark : Brightness.light,
            iconTheme:
                IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
            textTheme: TextTheme(
                headline6: TextStyle(
                    fontSize: 20, color: isDarkMode ? Colors.white : Colors.black, fontFamily: fontFamily))),

        /// 内容背景色
        scaffoldBackgroundColor:
            isDarkMode ? Colors.grey[850]! : Colors.grey[50]!,
        fontFamily: _fontFamily);
  }

  /// 数据持久化到shared preferences
  void _saveColor2Storage(MaterialColor themeColor) async {
    var index =
        ConstantUtil.themeColorSupport.keys.toList().indexOf(themeColor);
    SpUtil.putInt(kThemeColorIndex, index);
  }

  void _saveDarkMode2Storage(int userDarkModeIndex) async {
    SpUtil.putInt(kThemeUserDarkMode, userDarkModeIndex);
  }

  void _saveFontFamily2Storage(String fontFamily) async {
    SpUtil.putString(kFontFamily, fontFamily);
  }

  /// 深色模式选择
  static String darkModeName(index, context) {
    switch (index) {
      case 0:
        return S.of(context).autoBySystem;
      case 1:
        return S.of(context).normalMode;
      case 2:
        return S.of(context).darkMode;
      default:
        return '';
    }
  }
}
