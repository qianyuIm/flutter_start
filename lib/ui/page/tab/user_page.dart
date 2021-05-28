import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as sp;
import 'package:flutter_start/config/data.dart';
import 'package:flutter_start/generated/l10n.dart';
import 'package:flutter_start/router/router_manger.dart';
import 'package:flutter_start/ui/widget/image_load_view.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
var style = DefaultTextStyle.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('我的',),
        leading: Text(''),
      ),
      body: Column(
        children: [
          Text('我的'),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(MyRouterName.theme_color_setting);
            },
            child: Text('皮肤设置'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(MyRouterName.font_setting);
            },
            child: Text('字体设置'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(MyRouterName.language_setting);
            },
            child: Text('语言设置'),
          ),
        ],
      ),
    );
  }
}
