import 'package:flutter/material.dart';

class TabIconData {
  TabIconData(
      {required this.icon,
      required this.messageText,
      required this.name,
      required this.index,
      required this.isSelected,
      this.animationController});

  final IconData icon;
  final int index;
  late bool isSelected;
  final String messageText;
  final String name;
  AnimationController? animationController;

  static List<TabIconData> tabIconsList = [
    TabIconData(
        icon: Icons.home,
        messageText: 'Home',
        name: 'tabHome',
        index: 0,
        isSelected: false,
        animationController: null),
    TabIconData(
        icon: Icons.home,
        messageText: 'Home',
        name: 'tabHome',
        index: 1,
        isSelected: false,
        animationController: null),
    TabIconData(
        icon: Icons.insert_emoticon,
        messageText: 'Effect',
        name: 'tabEffect',
        index: 2,
        isSelected: false,
        animationController: null),
    TabIconData(
        icon: Icons.insert_emoticon,
        messageText: 'Me',
        name: 'tabUser',
        index: 3,
        isSelected: false,
        animationController: null),
  ];
}
