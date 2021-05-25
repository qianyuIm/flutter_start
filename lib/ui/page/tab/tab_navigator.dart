import 'package:flutter/material.dart';
import 'package:flutter_start/router/router_manger.dart';
import 'package:flutter_start/ui/page/tab/home_page.dart';
import 'package:flutter_start/ui/page/tab/user_page.dart';

final List<Widget> _pages = <Widget>[HomePage(), UserPage()];
final List<String> _bottomAppBarTitles = ["首页", "我的"];
final List<IconData> _bottomAppBarIconDatas = [
  Icons.home,
  Icons.insert_emoticon,
];

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  DateTime? _lastPressed;
  var _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildSearchButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(context),
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

  /// search
  Widget _buildSearchButton(BuildContext context) {
    var iconColor = Theme.of(context).accentColor;
    return FloatingActionButton(
      elevation: 2,
      backgroundColor: iconColor,
      child: const Icon(Icons.search),
      onPressed: () {
        Navigator.of(context).pushNamed(MyRouterName.setting);
      },
    );
  }

  /// bottom bar
  Widget _buildBottomNavigationBar(BuildContext context) {
    return TabNavigatorBottomBar(
      onTap: (int index) {
        _pageController.jumpToPage(index);
      },
      onLongPress: (value) {},
    );
  }
}

class TabNavigatorBottomBar extends StatefulWidget {
  /// 点击事件
  final ValueChanged<int> onTap;

  /// 长按事件
  final ValueChanged<int>? onLongPress;
  TabNavigatorBottomBar({required this.onTap, this.onLongPress});
  @override
  _TabNavigatorBottomBarState createState() => _TabNavigatorBottomBarState();
}

class _TabNavigatorBottomBarState extends State<TabNavigatorBottomBar> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var itemWidth = MediaQuery.of(context).size.width / 5;
    return BottomAppBar(
      elevation: 8,
      shape: CircularNotchedRectangle(),
      notchMargin: _bottomAppBarTitles.length + 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 49, width: itemWidth, child: _bottomAppBarItem(0)),
          // SizedBox(height: 49, width: itemWidth, child: _bottomAppBarItem(1)),
          SizedBox(height: 49, width: itemWidth),
          // SizedBox(height: 49, width: itemWidth, child: _bottomAppBarItem(2)),
          SizedBox(height: 49, width: itemWidth, child: _bottomAppBarItem(1))
        ],
      ),
    );
  }

  Widget _bottomAppBarItem(int index) {
    var iconColor = Theme.of(context).unselectedWidgetColor;
    var textStyle = TextStyle(fontSize: 12.0, color: iconColor);
    if (_selectedIndex == index) {
      iconColor = Theme.of(context).accentColor;
      textStyle = TextStyle(fontSize: 13.0, color: iconColor);
    }
    Widget item = Container(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_bottomAppBarIconDatas[index],color: iconColor),
            Text(_bottomAppBarTitles[index],style: textStyle)
          ],
        ),
        onTap: () {
          setState(() {
            if (_selectedIndex != index) {
              _selectedIndex = index;
              widget.onTap.call(index);
            }
          });
        },
        onLongPress: () {
          widget.onLongPress?.call(index);
        },
      ),
    );
    return item;
  }
}
