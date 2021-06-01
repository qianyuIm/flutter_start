import 'package:flutter/material.dart';
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

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late  List<TabIconData> tabIconsList;
  var _pageController = PageController();
  DateTime? _lastPressed;
  late int _selectedIndex;
  @override
  void initState() {
    _selectedIndex = 0;
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
    tabIconsList =  TabIconData.tabIconsList(context);
    tabIconsList.forEach((element) {
      element.isSelected = false;
    });
    tabIconsList[_selectedIndex].isSelected = true;
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

  
  Widget _buildBottomBar() {
    return BottomBarView(
      tabIconsList: tabIconsList,
      changeIndex: (index) {
        print("点击了$index");
        _pageController.jumpToPage(index);
        _selectedIndex = index;
      },
      searchClick: () {
        print("点击了search");
      },
    );
  }
}
