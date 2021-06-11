import 'package:flutter/material.dart';
import 'package:flutter_start/help/image_helper.dart';
import 'package:flutter_start/ui/widget/user_flexible_space_bar.dart';
import 'package:flutter_start/ui/widget/user_sliver_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserSliverAppBarSettings {
  static double left = 20;
  static double headerContentHeight = 54;
  static double middleMarginTop = 20;
  static double meddleHeight = 50;

  static double bottomMarginTop = 0;
  static double bottomHeight = 165.w;

  static double contentHeight = headerContentHeight +
      middleMarginTop +
      meddleHeight +
      bottomMarginTop +
      bottomHeight;
}

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = ScrollController();

  /// 初始化偏移距离
  double initOffset = 100;
  double transformOffestY = 100;
  double cardBorderOpacity = 1;

  /// 当前偏移量
  double currentOffset = 0;
  double expandedHeight =
      UserSliverAppBarSettings.contentHeight + kToolbarHeight;
  bool isVisible = false;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _scrollController.animateTo(initOffset,
          duration: Duration(milliseconds: 200), curve: Curves.easeInQuad);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification &&
              notification.depth == 0) {
            /// 滚动
            _onScroll(notification.metrics.pixels);
          }
          ///TODO: 在这里写的话会有个延时，应该在哪里监听呢？
          if (notification is ScrollEndNotification &&
              currentOffset < initOffset) {
            Future.delayed(Duration.zero, () {
              _scrollController.animateTo(initOffset,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeInQuad);
            });
          }
          return false;
        },
        child: Listener(
          onPointerUp: (event) {
            if (currentOffset < initOffset) {
              _scrollController.animateTo(initOffset,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeInQuad);
            }
          },
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  UserSliverAppBar(
                    stretch: true,
                    expandedHeight: expandedHeight,
                    pinned: true,
                    actions: [
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          size: 25,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          size: 25,
                        ),
                        onPressed: () {},
                      )
                    ],
                    flexibleSpace: UserFlexibleSpaceBar(
                        content: _flexibleSpaceContent(),
                        trickContent: _flexibleSpaceTrickContent()),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (_, index) => Container(
                              // color: Colors.purple,
                              alignment: Alignment.center,
                              width: 100,
                              height: 50,
                              child: Text('index => $index'),
                            ),
                        childCount: 40),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _flexibleSpaceContent() {
    return Visibility(
      visible: isVisible,
      child: Container(
        height: UserSliverAppBarSettings.contentHeight,
        // color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _flexibleSpaceHeader(),
            _flexibleSpaceMiddle(),
            _flexibleSpaceBottom()
          ],
        ),
      ),
    );
  }

  Widget _flexibleSpaceTrickContent() {
    return Visibility(
      visible: !isVisible,
      child: Container(
        height: UserSliverAppBarSettings.contentHeight,
        // color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _flexibleSpaceHeader(),
            _flexibleSpaceMiddle(),
            _flexibleSpaceBottom()
          ],
        ),
      ),
    );
  }

  Widget _flexibleSpaceHeader() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: UserSliverAppBarSettings.left),
          width: UserSliverAppBarSettings.headerContentHeight,
          height: UserSliverAppBarSettings.headerContentHeight,
          child: GestureDetector(
            onTap: () {
              print('点击头像');
            },
            child: PhysicalModel(
              color: Colors.transparent,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(27),
              child: Image.asset(
                ImageHelper.wrapAssets('user_sliver_bar_avatar_default'),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15),
          child: Column(
            children: [Text('点击登录'), Text('我的身份')],
          ),
        ),
      ],
    );
  }

  Widget _flexibleSpaceMiddle() {
    return Container(
      // color: Colors.purple,
      margin: EdgeInsets.only(
          left: UserSliverAppBarSettings.left,
          right: UserSliverAppBarSettings.left,
          top: UserSliverAppBarSettings.middleMarginTop),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _meddleItem('单词本', 'user_sliver_bar_vocabulary'),
          _meddleItem('速记单词', 'user_sliver_bar_memory'),
          _meddleItem('专栏关注', 'user_sliver_bar_follow'),
          _meddleItem('专栏收藏', 'user_sliver_bar_favorite'),
        ],
      ),
    );
  }

  _meddleItem(String title, String iconName) {
    return InkWell(
        onTap: () {
          print('object');
        },
        child: Container(
          // color: Colors.black.withAlpha(100),
          height: UserSliverAppBarSettings.meddleHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageHelper.wrapAssets(iconName),
                width: 27,
                height: 27,
                // color: Colors.red,
              ),
              Text(title)
            ],
          ),
        ));
  }

  Widget _flexibleSpaceBottom() {
    return Container(
        margin: EdgeInsets.only(top: UserSliverAppBarSettings.bottomMarginTop),
        // color: Colors.red,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
              ImageHelper.wrapAssets('user_sliver_bar_card'),
              width: 375.w,
              fit: BoxFit.fill,
              // height: UserSliverAppBarSettings.bottomHeight,
            ),
            Container(
                color: Colors.transparent,
                child: Opacity(
                  opacity: cardBorderOpacity,
                  child: Transform.translate(
                    offset: Offset(0, -transformOffestY),
                    child: Image.asset(
                      ImageHelper.wrapAssets('user_sliver_bar_card_border'),
                      width: 375.w,
                      fit: BoxFit.fitWidth,
                      // fit: BoxFit.fill,
                    ),
                  ),
                )),
          ],
        ));
  }

  /// 监听滚动
  _onScroll(offset) {
    isVisible = offset < 0;
    transformOffestY = offset > 0 ? offset : 0;
    if (offset < initOffset) {
      cardBorderOpacity = 1;
    } else {
      var opacity = (1.0 - (offset - initOffset) / 100);
      cardBorderOpacity = opacity < 0 ? 0 : opacity;
    }

    if (offset > expandedHeight) {
    } else {
      setState(() {
        currentOffset = offset;
      });
    }
  }
}
