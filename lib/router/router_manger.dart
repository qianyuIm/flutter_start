
import 'package:flutter/material.dart';
import 'package:flutter_start/router/router_utils.dart';
import 'package:flutter_start/ui/page/intro/intro_page.dart';
import 'package:flutter_start/ui/page/splash/splash_page.dart';
import 'package:flutter_start/ui/page/tab/tab_navigator.dart';
import 'package:flutter_start/ui/page/user/setting/font_setting.dart';
import 'package:flutter_start/ui/page/user/setting/language_setting.dart';
import 'package:flutter_start/ui/page/user/setting/theme_color_setting.dart';

class MyRouterName {
  /// 闪屏页
  static const String splash = 'splash';
  /// 新特性
  static const String intro = 'IntroPage';
  /// 首页
  static const String tab = '/';
  /// 应用设置页面
  static const String setting = 'settingPage';
  /// 主题色设置
  static const String theme_color_setting = 'ThemeColorSettingPage';
  /// 字体设置
  static const String font_setting = 'FontSettingPage';
  ///语言设置
  static const String language_setting = 'LanguageSettingPage';

  static const String demo = 'demo';
}

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyRouterName.splash:
        return NoAnimRouteBuilder(SplashPage());
      case MyRouterName.intro:
        return NoAnimRouteBuilder(IntroPage());
      case MyRouterName.tab:
        return NoAnimRouteBuilder(TabNavigator());
      case MyRouterName.setting:
        return Right2LeftRouter(SplashPage());
      case MyRouterName.theme_color_setting:
        return Right2LeftRouter(ThemeColorSettingPage());
      case MyRouterName.font_setting:
        return Right2LeftRouter(FontSettingPage());
      case MyRouterName.language_setting:
        return Right2LeftRouter(LanguageSettingPage());




      case MyRouterName.demo:
      return Left2RightRouter(SplashPage());
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
