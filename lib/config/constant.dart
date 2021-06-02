import 'package:flutter/material.dart';

class ConstantUtil {
  /// 主题颜色列表
 static final themeColorSupport = <MaterialColor, String>{
    Colors.red: "毁灭之红",
    Colors.orange: "愤怒之橙",
    Colors.yellow: "警告之黄",
    Colors.green: "伪装之绿",
    Colors.blue: "冷漠之蓝",
    Colors.indigo: "无限之靛",
    Colors.purple: "神秘之紫",
  };

  /// 字体列表
  static final fontFamilySupport = [
    'system',
    'KuaiLe',
    
  ];
  /// 语言支持
  static final localeSupport = ['auto', 'zh-CN', 'en'];
  /// 深色模式支持
  static final darkModeSupport = ['auto', 'normal', 'dark'];
  
}