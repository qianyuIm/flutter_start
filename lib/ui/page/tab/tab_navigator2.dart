
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/generated/l10n.dart';
import 'package:flutter_start/ui/page/tab/home_page.dart';
import 'package:flutter_start/ui/page/tab/user_page.dart';

List<Widget> pages = <Widget>[
  HomePage(),
  HomePage(),
  HomePage(),
  HomePage(),
  UserPage()
];

class TabNavigator2 extends StatefulWidget {
  TabNavigator2({Key? key}) : super(key: key);

  @override
  _TabNavigator2State createState() => _TabNavigator2State();
}

class _TabNavigator2State extends State<TabNavigator2> {
  var _pageController = PageController();
  int _selectedIndex = 0;
  DateTime? _lastPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressed == null) {
            //两次点击间隔超过1秒则重新计时
            _lastPressed = DateTime.now();
            return false;
          }
          return true;
        },
        child: PageView.builder(
          itemBuilder: (ctx, index) => pages[index],
          itemCount: pages.length,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.red,
        unselectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: S.of(context).tabHome,
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: S.of(context).tabHome,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            label: S.of(context).tabHome,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_split),
            label: S.of(context).tabHome,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_emoticon),
            label: S.of(context).tabHome,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  
}
