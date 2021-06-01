import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/config/constant.dart';
import 'package:flutter_start/generated/l10n.dart';

class LocaleModel extends ChangeNotifier {

  
  static const kLocaleIndex = 'kLocaleIndex';

  late int _localeIndex;

  int get localeIndex => _localeIndex;

  Locale? get locale {
    if (_localeIndex > 0) {
      var value = ConstantUtil.localeSupport[_localeIndex].split("-");
      return Locale(value[0], value.length == 2 ? value[1] : '');
    }
    // 跟随系统
    return null;
  }

  LocaleModel() {
    _localeIndex = SpUtil.getInt(kLocaleIndex)!;
    
  }

  switchLocale(int? index) {
    _localeIndex = index ?? _localeIndex;
    notifyListeners();
    SpUtil.putInt(kLocaleIndex, _localeIndex);
  }

  static String localeName(index, context) {
    switch (index) {
      case 0:
        return S.of(context).autoBySystem;
      case 1:
        return '中文';
      case 2:
        return 'English';
      default:
        return '';
    }
  }
  
}
