import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/config/inch.dart';
import 'package:flutter_start/model/tabIcon_data.dart';
import 'dart:math' as math;

class BottomBarView extends StatefulWidget {
  const BottomBarView(
      {Key? key,
      required this.tabIconsList,
      required this.changeIndex,
      required this.searchClick})
      : super(key: key);

  final List<TabIconData> tabIconsList;
  final Function(int index) changeIndex;
  final Function searchClick;
  @override
  _BottomBarViewState createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView>
    with TickerProviderStateMixin {
  /// tabbar 高度
  static double tabbarHeight = 60.0;
  static double tabClipperRadius = 36.0;
  static double tabClipperHeight = tabClipperRadius + 60;

  static double initHeight = ScreenUtil().bottomBarHeight + tabClipperHeight;

  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var accentColor = Theme.of(context).accentColor;
    var bottomAppBarColor = Theme.of(context).bottomAppBarColor;
    return Container(
        height: initHeight,
        color: Colors.transparent,
        child: Column(
          children: [
            const Expanded(child: SizedBox()),
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                      child: PhysicalShape(
                        color: bottomAppBarColor,
                        elevation: 16.0,
                        clipper: TabClipper(
                          radius: Tween<double>(begin: 0.0, end: 1.0)
                                  .animate(CurvedAnimation(
                                      parent: _animationController,
                                      curve: Curves.fastOutSlowIn))
                                  .value *
                              tabClipperRadius,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: tabbarHeight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,

                                  /// tabIcons
                                  children: [
                                    TabIcons(
                                        tabIconData: widget.tabIconsList[0],
                                        removeAllSelect: () {
                                          setRemoveAllSelection(
                                              widget.tabIconsList[0]);
                                          widget.changeIndex(0);
                                        }),
                                    TabIcons(
                                        tabIconData: widget.tabIconsList[1],
                                        removeAllSelect: () {
                                          setRemoveAllSelection(
                                              widget.tabIconsList[1]);
                                          widget.changeIndex(1);
                                        }),
                                    SizedBox(
                                      width: Tween<double>(begin: 0.0, end: 1.0)
                                              .animate(CurvedAnimation(
                                                  parent: _animationController,
                                                  curve: Curves.fastOutSlowIn))
                                              .value *
                                          64.0,
                                    ),
                                    TabIcons(
                                        tabIconData: widget.tabIconsList[2],
                                        removeAllSelect: () {
                                          setRemoveAllSelection(
                                              widget.tabIconsList[2]);
                                          widget.changeIndex(2);
                                        }),
                                    TabIcons(
                                        tabIconData: widget.tabIconsList[3],
                                        removeAllSelect: () {
                                          setRemoveAllSelection(
                                              widget.tabIconsList[3]);
                                          widget.changeIndex(3);
                                        }),
                                  ],
                                ),
                              ),
                            ),

                            /// 安全区域
                            SizedBox(
                              height: ScreenUtil().bottomBarHeight,
                              
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // ),

                /// 中间按钮
                Padding(
                  padding:
                      EdgeInsets.only(bottom: ScreenUtil().bottomBarHeight),
                  child: SizedBox(
                    width: tabClipperRadius * 2,
                    height: tabClipperHeight,
                    child: Container(
                      alignment: Alignment.topCenter,
                      color: Colors.transparent,
                      child: SizedBox(
                        width: tabClipperRadius * 2,
                        height: tabClipperRadius * 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ScaleTransition(
                            alignment: Alignment.center,
                            scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                    parent: _animationController,
                                    curve: Curves.fastOutSlowIn)),
                            child: Container(
                              decoration: BoxDecoration(
                                color: accentColor,
                                gradient: LinearGradient(
                                    colors: [accentColor.withAlpha(40), accentColor,accentColor.withAlpha(100)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                shape: BoxShape.circle,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: accentColor.withOpacity(0.3),
                                      offset: const Offset(8, 8.0),
                                      blurRadius: 8.0),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  onTap: () {
                                    widget.searchClick();
                                  },
                                  child: Icon(
                                    Icons.search,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  void setRemoveAllSelection(TabIconData tabIconData) {
    if (!mounted) return;
    setState(() {
      widget.tabIconsList.forEach((TabIconData tab) {
        tab.isSelected = false;
        if (tabIconData.index == tab.index) {
          tab.isSelected = true;
        }
      });
    });
  }
}

class TabIcons extends StatefulWidget {
  const TabIcons(
      {Key? key, required this.tabIconData, required this.removeAllSelect})
      : super(key: key);

  final TabIconData tabIconData;
  final Function removeAllSelect;
  @override
  _TabIconsState createState() => _TabIconsState();
}

class _TabIconsState extends State<TabIcons> with TickerProviderStateMixin {
  @override
  void initState() {
    widget.tabIconData.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          if (!mounted) return;
          widget.removeAllSelect();
          widget.tabIconData.animationController?.reverse();
        }
      });
    super.initState();
  }

  void setAnimation() {
    widget.tabIconData.animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            if (!widget.tabIconData.isSelected) {
              setAnimation();
            }
          },
          child: IgnorePointer(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                ScaleTransition(
                  alignment: Alignment.center,
                  scale: Tween<double>(begin: 0.88, end: 1.0).animate(
                      CurvedAnimation(
                          parent: widget.tabIconData.animationController!,
                          curve:
                              Interval(0.1, 1.0, curve: Curves.fastOutSlowIn))),
                  child: Icon(
                    widget.tabIconData.icon,
                    size: 34,
                  ),
                ),
                Positioned(
                  top: 4,
                  left: 6,
                  right: 0,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: widget.tabIconData.animationController!,
                            curve: Interval(0.2, 1.0,
                                curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 6,
                  bottom: 8,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: widget.tabIconData.animationController!,
                            curve: Interval(0.5, 0.8,
                                curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 8,
                  bottom: 0,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: widget.tabIconData.animationController!,
                            curve: Interval(0.5, 0.6,
                                curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TabClipper extends CustomClipper<Path> {
  TabClipper({this.radius = 36.0});

  final double radius;

  @override
  Path getClip(Size size) {
    final Path path = Path();

    final double v = radius * 2;
    path.lineTo(0, 0);
    path.arcTo(Rect.fromLTWH(0, 0, radius, radius), degreeToRadians(180),
        degreeToRadians(90), false);
    path.arcTo(
        Rect.fromLTWH(
            ((size.width / 2) - v / 2) - radius + v * 0.04, 0, radius, radius),
        degreeToRadians(270),
        degreeToRadians(70),
        false);

    path.arcTo(Rect.fromLTWH((size.width / 2) - v / 2, -v / 2, v, v),
        degreeToRadians(160), degreeToRadians(-140), false);

    path.arcTo(
        Rect.fromLTWH((size.width - ((size.width / 2) - v / 2)) - v * 0.04, 0,
            radius, radius),
        degreeToRadians(200),
        degreeToRadians(70),
        false);
    path.arcTo(Rect.fromLTWH(size.width - radius, 0, radius, radius),
        degreeToRadians(270), degreeToRadians(90), false);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TabClipper oldClipper) => true;

  double degreeToRadians(double degree) {
    final double redian = (math.pi / 180) * degree;
    return redian;
  }
}
