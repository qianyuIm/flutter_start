import 'package:intl/intl.dart';

/// tabbar  使用  
class LocaleHelper {
  /// 参考： l10n.dart 写法
  static String localeString(String messageText, String name) {
     return Intl.message(
      messageText,
      name: name,
      desc: '',
      args: [],
    );
  }
}