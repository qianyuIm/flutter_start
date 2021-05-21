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
  static const List<MaterialColor> themeColors = [Colors.red, Colors.green];

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
}
