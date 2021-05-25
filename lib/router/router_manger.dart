
import 'package:flutter/material.dart';
import 'package:flutter_start/router/router_utils.dart';
import 'package:flutter_start/ui/page/splash/splash_page.dart';
import 'package:flutter_start/ui/page/tab/scroll_header_demo.dart';
import 'package:flutter_start/ui/page/tab/tab_navigator.dart';

class MyRouterName {
  /// 闪屏页
  static const String splash = 'splash';
  /// 首页
  static const String tab = '/';
  /// 应用设置页面
  static const String setting = 'settingPage';
}

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyRouterName.splash:
        return NoAnimRouteBuilder(SplashPage());
      case MyRouterName.tab:
        return NoAnimRouteBuilder(TabNavigator());
      case MyRouterName.setting:
        return NoAnimRouteBuilder(ScrollHeaderDemoPage());
      
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              body:
                  Center(child: Text('No route defined for ${settings.name}')),
            );
          },
        );
    }
  }
}
