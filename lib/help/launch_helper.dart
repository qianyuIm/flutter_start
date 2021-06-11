import 'package:flustars/flustars.dart';
import 'package:flutter_start/app_start.dart';
import 'package:flutter_start/router/router_manger.dart';

class LaunchHelper {
  /// 是否当前版本首次启动
  static const kVersionFirstOpen = 'version_firstOpen';


  static String initialRoute()  {
    var storage = SpUtil.getString(kVersionFirstOpen)!;
    ///  TODO： 测试阶段 
    return MyRouterName.intro;
    ///  展示新特性
    if (storage != AppStart.packageVersion) {
      return MyRouterName.intro;
    }
    return MyRouterName.splash;
  }
  /// 保存版本号
  static storage() {
      SpUtil.putString(kVersionFirstOpen,  AppStart.packageVersion);
  }
}