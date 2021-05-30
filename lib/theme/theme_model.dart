import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/config/constant.dart';
import 'package:flutter_start/help/theme_helper.dart';

class ThemeItem {
  Color appBarTitleColor = Colors.red;
}

class ThemeModel extends ChangeNotifier {
  static const kThemeColorIndex = 'kThemeColorIndex';
  static const kThemeUserDarkMode = 'kThemeUserDarkMode';
  static const kFontFamily = 'kFontFamily';

  /// 用户选择的明暗模式
  late bool _isUserDarkMode;

  /// 当前主题颜色
  late MaterialColor _themeColor;

  /// 当前字体
  late String _fontFamily;

  late ThemeItem item;

  ThemeModel() {
    _isUserDarkMode = SpUtil.getBool(kThemeUserDarkMode)!;
    _themeColor = ConstantUtil.themeColorSupport.keys
        .toList()[SpUtil.getInt(kThemeColorIndex)!];
    _fontFamily = SpUtil.getString(kFontFamily, defValue: 'system')!;
   item = ThemeItem();

  }

  String get fontFamily => _fontFamily;
  MaterialColor get themeColor => _themeColor;

  /// 切换指定色彩
  ///
  /// 没有传[brightness]就不改变brightness,color同理
  void switchTheme({bool? userDarkMode, MaterialColor? color}) {
    _isUserDarkMode = userDarkMode ?? _isUserDarkMode;
    _themeColor = color ?? _themeColor;
    notifyListeners();
    _saveTheme2Storage(_isUserDarkMode, _themeColor);
  }

  /// 切换字体
  void switchFontFamily({required String fontFamily}) {
    _fontFamily = fontFamily;
    notifyListeners();
    _saveFontFamily2Storage(_fontFamily);
  }

  /// 自定义 themeData
  ThemeData themeData({bool isPlatformDarkMode: true}) {
    var isDark = isPlatformDarkMode || _isUserDarkMode;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;

    var themeColor = _themeColor;

    item.appBarTitleColor = isDark ? Colors.red : Colors.blue;
    /// 次级颜色
    var accentColor = isDark ? themeColor[800] : _themeColor;

    /// TODO: 不设置primaryColor 的原因是 黑暗模式
    var themeData = ThemeData(
        brightness: brightness,
        primaryColorBrightness: Brightness.dark,
        accentColorBrightness: Brightness.dark,
        primarySwatch: themeColor,
        accentColor: accentColor,

        /// 自定义 tabbar 背景色
        bottomAppBarColor: isDark ? Colors.grey[800]! : Colors.white,

        /// 内容背景色
        scaffoldBackgroundColor: isDark ? Colors.grey[850]! : Colors.grey[50]!,
        // unselectedWidgetColor: Colors.yellow,
        fontFamily: _fontFamily);
        
    themeData = themeData.copyWith(
        brightness: brightness,
        accentColor: accentColor,
        cupertinoOverrideTheme: CupertinoThemeData(
            primaryColor: themeColor, brightness: brightness),
        appBarTheme: themeData.appBarTheme.copyWith(elevation: 0),
        splashColor: themeColor.withAlpha(50),
        hintColor: themeData.hintColor.withAlpha(90),
        errorColor: Colors.red,
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: accentColor,
            selectionColor: accentColor?.withAlpha(60),
            selectionHandleColor: accentColor?.withAlpha(60)),
        textTheme: themeData.textTheme.copyWith(
            subtitle1: themeData.textTheme.subtitle1
                ?.copyWith(textBaseline: TextBaseline.alphabetic)),
        toggleableActiveColor: accentColor,
        chipTheme: themeData.chipTheme.copyWith(
          pressElevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 10),
          labelStyle: themeData.textTheme.caption,
          backgroundColor: themeData.chipTheme.backgroundColor.withOpacity(0.1),
        ),
        inputDecorationTheme: ThemeHelper.inputDecorationTheme(themeData));
    return themeData;
  }

  /// 数据持久化到shared preferences
  void _saveTheme2Storage(bool userDarkMode, MaterialColor themeColor) async {
    var index =
        ConstantUtil.themeColorSupport.keys.toList().indexOf(themeColor);
    await Future.wait([
      SpUtil.putBool(kThemeUserDarkMode, userDarkMode)!,
      SpUtil.putInt(kThemeColorIndex, index)!
    ]);
  }

  void _saveFontFamily2Storage(String fontFamily) async {
    SpUtil.putString(kFontFamily, fontFamily);
  }
}
