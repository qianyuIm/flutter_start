import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/config/inch.dart';
import 'package:flutter_start/model/tabIcon_data.dart';
import 'package:flutter_start/ui/page/tab/home_page.dart';
import 'package:flutter_start/ui/page/tab/user_page.dart';
import 'package:flutter_start/ui/widget/bottom_navigation_view.dart';

final List<Widget> _pages = <Widget>[
  HomePage(),
  HomePage(),
  UserPage(),
  UserPage()
];

class TabNavigator1 extends StatefulWidget {
  @override
  _TabNavigator1State createState() => _TabNavigator1State();
}

class _TabNavigator1State extends State<TabNavigator1>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  var _pageController = PageController();
  DateTime? _lastPressed;

  @override
  void initState() {
    tabIconsList.forEach((element) {
      element.isSelected = false;
    });
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomBar(),
      body: WillPopScope(
        onWillPop: () async {
          _lastPressed = _lastPressed ?? DateTime.now();
          if (DateTime.now().difference(_lastPressed!) > Duration(seconds: 1)) {
            return false;
          }
          return true;
        },
        child: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: _pages.length,
          itemBuilder: (context, index) => _pages[index],
          controller: _pageController,
        ),
      ),
    );
  }

  // Widget _buildBottomBar() {
  //   var yellowBox = Container(
  //     color: Colors.yellow,
  //     height: 100,
  //     width: 100,
  //   );

  //   var redBox = Container(
  //     color: Colors.red,
  //     height: 90,
  //     width: 90,
  //   );

  //   var greenBox = Container(
  //     color: Colors.red,
  //     height: 80,
  //     width: ScreenUtil().screenWidth ,
  //   );

  //   var cyanBox = Container(
  //     color: Colors.cyanAccent,
  //     height: 70,
  //     width: 70,
  //   );

  //   return Container(
  //       width: ScreenUtil().scaleWidth,
  //       height: 120,
  //       color: Colors.black,
  //       child: Stack(
  //         children: <Widget>[
  //           // yellowBox,
  //           // redBox,
  //           Positioned(top: 20, child: greenBox),

  //           Positioned(
  //             child: cyanBox,
  //             bottom: 10,
  //             right: 10,
  //           )
  //         ],
  //       ));
  // }
  Widget _buildBottomBar() {
    return BottomBarView(
      tabIconsList: tabIconsList,
      changeIndex: (index) {
        print("点击了$index");
      },
      searchClick: () {
        print("点击了search");
      },
    );
  }
}
