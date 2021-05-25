import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  static const kThemeColorIndex = 'kThemeColorIndex';
  static const kThemeUserDarkMode = 'kThemeUserDarkMode';
  static const kFontIndex = 'kFontIndex';

  /// 字体列表
  static const fontValueList = [
    'system',
    'kuaile',
    'IndieFlower',
    'BalooBhai2',
    'Inconsolata',
    'Neucha',
    'ComicNeue',
    'CHOPS'
  ];

  /// 主题颜色列表
  static const List<MaterialColor> themeColors = [
    Colors.red, 
    Colors.green,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple];

  /// 用户选择的明暗模式
  late bool _isUserDarkMode;

  /// 当前主题颜色
  late MaterialColor _themeColor;

  /// 当前字体索引
  late int _fontIndex;

  ThemeModel() {
    _isUserDarkMode = SpUtil.getBool(kThemeUserDarkMode)!;
    _themeColor = themeColors[SpUtil.getInt(kThemeColorIndex)!];
    _fontIndex = SpUtil.getInt(kFontIndex)!;
  }
  int get fontIndex => _fontIndex;

  themeData({bool isPlatformDarkMode: false}) {
    var isDark = isPlatformDarkMode || _isUserDarkMode;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;

    var themeColor = _themeColor;
    var accentColor = isDark ? themeColor[700] : _themeColor;

    var themeData = ThemeData(
      brightness: brightness,
      primaryColorBrightness: Brightness.dark,
        accentColorBrightness: Brightness.dark,
        primarySwatch: themeColor,
        accentColor: accentColor,
        fontFamily: fontValueList[fontIndex]
    );
    return themeData;
  }
}
