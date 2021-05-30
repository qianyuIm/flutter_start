

import 'package:flutter/material.dart';
import 'package:flutter_start/generated/l10n.dart';

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


  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(icon: Icons.home, label: S.current.tabHome, index: 0, isSelected: false,animationController: null),
    TabIconData(icon: Icons.home, label: S.current.tabHome, index: 1, isSelected: false,animationController: null),
    TabIconData(icon: Icons.insert_emoticon, label: S.current.tabUser, index: 2, isSelected: false,animationController: null),
    TabIconData(icon: Icons.insert_emoticon, label: S.current.tabHome, index: 3, isSelected: false,animationController: null),
  ];
}
