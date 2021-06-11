import 'package:flutter/material.dart';

enum ImageHelperType { png, jpg }

class ImageHelper {
  /// 本地图片加载路径
  static String wrapAssets(String name,
      {ImageHelperType type = ImageHelperType.png}) {
    String ext = '';
    switch (type) {
      case ImageHelperType.png:
        ext = '.png';
        break;
      case ImageHelperType.jpg:
        ext = '.jpg';
        break;
      default:
        break;
    }
    return "assets/images/" + name + ext;
  }
}
