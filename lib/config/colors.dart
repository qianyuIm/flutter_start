import 'package:flutter/material.dart';

class ColorUtil {
  
   static String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}