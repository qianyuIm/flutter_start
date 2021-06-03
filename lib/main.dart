import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/app_start.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_start/generated/l10n.dart';
import 'package:flutter_start/help/launch_helper.dart';
import 'package:flutter_start/router/router_manger.dart';
import 'package:flutter_start/theme/locale_model.dart';
import 'package:flutter_start/theme/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  
  /// 初始化后
  AppStart.init(() {
    
    runApp(MyApp());
  });
  
}
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return ScreenUtilInit(
      designSize: Size(375, 667),
      builder: () => MultiProvider(
        providers: [
          /// 皮肤
          ChangeNotifierProvider<ThemeModel>(
            create: (context) => ThemeModel(),
          ),
          /// 语言
          ChangeNotifierProvider<LocaleModel>(
            create: (context) => LocaleModel(),
          ),
        ],
        child: Consumer2<ThemeModel, LocaleModel>(
          builder: (context, themeModel, localeModel, child) {
            return RefreshConfiguration(
              hideFooterWhenNotFull: true,
              child:MaterialApp(
                /// 安卓任务管理器展示
                title: 'flutter start',
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                darkTheme: themeModel.themeData(isDarkMode: true),
                theme: themeModel.themeData(),
                themeMode: themeModel.getThemeMode(),
                locale: localeModel.locale,
                localizationsDelegates: const [
                  S.delegate,
                  RefreshLocalizations.delegate, //下拉刷新
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
                supportedLocales: S.delegate.supportedLocales,
                onGenerateRoute: MyRouter.generateRoute,
                initialRoute:  LaunchHelper.initialRoute(),
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: child!,
                  );
                },
              ),
            );
          },
        )),
    );
  }
}
