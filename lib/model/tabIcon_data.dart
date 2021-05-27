import 'package:flutter/material.dart';

class TabIconData {
  TabIconData(
      {required this.icon,
      required this.label,
      required this.index,
      required this.isSelected,
      this.animationController});

  final IconData icon;
  final int index;
  late bool isSelected;
  final String label;
   AnimationController? animationController;

  // final Color iconColor;
  // final Color selectedIconColor;
  // final TextStyle labelStyle;
  // final TextStyle selectedLabelStyle;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(icon: Icons.home, label: '首页', index: 0, isSelected: false,animationController: null),
    TabIconData(icon: Icons.home, label: '首页', index: 0, isSelected: false,animationController: null),
    TabIconData(icon: Icons.insert_emoticon, label: '我的', index: 1, isSelected: false,animationController: null),
    TabIconData(icon: Icons.insert_emoticon, label: '我的', index: 1, isSelected: false,animationController: null),


  ];
}
