import 'package:flutter_start/router/router_manger.dart';

class EffectItemModel {
  final String name;
  final double lever;
  final String info;
  final String routerName;
  EffectItemModel(
      {required this.name,
      required this.lever,
      required this.info,
      required this.routerName});
}

class EffectItemSupport {
  static List<EffectItemModel> effectItems = [
    EffectItemModel(
        name: '豆瓣详情滑动特效',
        lever: 3,
        info: '豆瓣详情页面滑动特效,点击查看具体效果,豆瓣详情页面滑动特效,点击查看具体效果.',
        routerName: MyRouterName.effect_douban),
  ];
}
