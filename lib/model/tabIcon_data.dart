

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


  static List<TabIconData> tabIconsList(BuildContext context) {
    return [
    TabIconData(icon: Icons.home, label: S.of(context).tabHome, index: 0, isSelected: false,animationController: null),
    TabIconData(icon: Icons.home, label: S.of(context).tabHome, index: 1, isSelected: false,animationController: null),
    TabIconData(icon: Icons.insert_emoticon, label: S.of(context).tabUser, index: 2, isSelected: false,animationController: null),
    TabIconData(icon: Icons.insert_emoticon, label: S.of(context).tabUser, index: 3, isSelected: false,animationController: null),
  ];
  }
}
