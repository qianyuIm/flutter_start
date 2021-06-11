import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/ui/page/specialEffects/douban/effect_douban_bottom_draggable_drawer.dart';

/// 底部的上拉抽屉
class EffectDouBanDrawer extends StatelessWidget {
  final bool isComingSoon;
  final EffectDouBanBottomDraggableDrawerController drawerController;

  const EffectDouBanDrawer(
      {Key? key, required this.isComingSoon, required this.drawerController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: EffectDouBanBottomDraggableDrawer(
        drawerController: drawerController,
        minOffsetDistance: ScreenUtil().screenHeight * 0.2,
        originalOffset: ScreenUtil().screenHeight * 0.98,
        draggableHeader: _buildHeader(),
        content: Container(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          color: Colors.white,
          child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 40,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('index -> $index'),
            );
          },
        ),
        )
        
         
      ),
    );
  }

Widget _buildHeader() {
  return Container(
    height: 90,
    width: ScreenUtil().screenWidth,
    color: Colors.red,
    child: Text('123333'),
  );
}

}
