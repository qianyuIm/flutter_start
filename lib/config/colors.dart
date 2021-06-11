import 'dart:math';

import 'package:flutter/material.dart';

class ColorUtil {
  static String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
      
  /// 随机色
  static Color random() {
    final _random = Random();
    return Color.fromRGBO(_random.nextInt(256), _random.nextInt(256),
        _random.nextInt(256), _random.nextDouble());
  }
}
