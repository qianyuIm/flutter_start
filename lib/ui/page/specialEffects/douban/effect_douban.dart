import 'package:flutter/material.dart';
import 'package:flutter_start/config/inch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/ui/page/specialEffects/douban/effect_douban_drawer.dart';
import 'package:flutter_start/ui/page/specialEffects/douban/effect_douban_bottom_draggable_drawer.dart';

class EffectDouBanPage extends StatefulWidget {
  final bool isComingSoon = false;

  ///appbar交互的判断临界offset
  static const edgeOffsetY = 200.0;

  @override
  _EffectDouBanPageState createState() => _EffectDouBanPageState();
}

class _EffectDouBanPageState extends State<EffectDouBanPage> {
  /// 滑动控制器
  final ScrollController _scrollController = ScrollController();
  /// 抽屉控制器
  final EffectDouBanBottomDraggableDrawerController drawerController = EffectDouBanBottomDraggableDrawerController();
  var indicatorOpacity = 0.0;
  ///appbar上标题的初始化透明度
  var titleOpacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          _mainBody(),
          _detailDrawer() 
          ],
      ),
    );
  }

  /// 主界面
  Widget _mainBody() {
    return Container(
      margin: const EdgeInsets.only(
          left: Inchs.leftMargin, right: Inchs.rightMargin),
      child: CustomScrollView(
        controller: _scrollController..addListener(scrollEffect),
        physics: BouncingScrollPhysics(),
        slivers: [
          _movieDetailHeader(),
          _movieDetailHeader(),
          _movieDetailHeader(),
          _movieDetailHeader(),
        ],
      ),
    );
  }

  /// 抽屉
  Widget _detailDrawer() {
    return EffectDouBanDrawer(
      isComingSoon: widget.isComingSoon,
      drawerController: drawerController,
    );
  }

  ///电影详情页面最上方的头布局

  Widget _movieDetailHeader() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        height: 250.h,
        color: Colors.orange,
      ),
    );
  }

  ///滚动监听动画交互
  void scrollEffect() {
double offset = _scrollController.offset;
    if (offset < 0) {
      offset = 0;
    } else if (offset > EffectDouBanPage.edgeOffsetY) {
      offset = EffectDouBanPage.edgeOffsetY;
    }

    ///这里用数学知识就可以算出来的交互效果
    indicatorOpacity = offset / EffectDouBanPage.edgeOffsetY;
    titleOpacity =
        (EffectDouBanPage.edgeOffsetY - offset) / EffectDouBanPage.edgeOffsetY;
    double indicatorOffsetY = -(1 / 5) * offset + 40;

    // appbarIndicatorKey.currentState.update(indicatorOpacity, indicatorOffsetY);
    // appbarTitleKey.currentState.update(titleOpacity);
  }
}
