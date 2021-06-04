import 'package:flutter/material.dart';
import 'package:flutter_start/model/tabIcon_data.dart';
import 'package:flutter_start/ui/page/tab/home_page.dart';
import 'package:flutter_start/ui/page/tab/test_page.dart';
import 'package:flutter_start/ui/page/tab/test_page1.dart';
import 'package:flutter_start/ui/page/tab/user_page.dart';
import 'package:flutter_start/ui/widget/bottom_navigation_view.dart';

final List<Widget> _pages = <Widget>[
  HomePage(),
  TestPage1(),
  TestPage(),
  UserPage()
];

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  var _pageController = PageController();
  DateTime? _lastPressed;
  @override
  void initState() {
    tabIconsList.map((e) {
      e.isSelected = false;
    });
    tabIconsList[0].isSelected = true;
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
      floatingActionButton: MyFloatingActionButton(searchClick: () {
        print('object');
      },),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

  Widget _buildBottomBar() {

    return BottomBarView(
      tabIconsList: tabIconsList,
      changeIndex: (index) {
        print("点击了$index");
        _pageController.jumpToPage(index);
      },
      searchClick: () {
        print("点击了search");
      },
    );
  }
}
