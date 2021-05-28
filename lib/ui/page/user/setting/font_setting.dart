import 'package:flutter/material.dart';
import 'package:flutter_start/config/constant.dart';
import 'package:flutter_start/generated/l10n.dart';
import 'package:flutter_start/theme/theme_model.dart';
import 'package:flutter_start/ui/widget/circle.dart';
import 'package:flutter_start/ui/widget/feedback_widget.dart';
import 'package:provider/provider.dart';

class FontSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).fontSetting),
      ),
      body: _buildFontCell(
          context, ConstantUtil.fontFamilySupport, themeModel.fontFamily, themeModel),
    );
  }

  Widget _buildFontCell(
      BuildContext context,
       List<String> fontFamilySupport,
        String fontFamily,
        ThemeModel themeModel) {
    var themeColor = Theme.of(context).primaryColor;
    return GridView.count(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.5,
      children: fontFamilySupport.map((e) => FeedbackWidget(
        a: 0.95,
        duration: Duration(milliseconds: 200),
        onPressed: () {
          themeModel.switchFontFamily(fontFamily: e);
        },
        child: Card(
      shadowColor: Theme.of(context).primaryColor,
      elevation: 5,
      child: GridTile(
        header: Container(
          height: 30,
          padding: EdgeInsets.only(left: 10, right: 5),
          color: e == fontFamily ? themeColor.withAlpha(100) : themeColor.withAlpha(30),
          child: Row(
              children: [
                Text(e,style: TextStyle(fontFamily: e),),
                Spacer(),
                if (e == fontFamily) Circle(color: themeColor,)
              ],
          ),
        ),
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                themeColor.withAlpha(40),
                themeColor.withAlpha(80),
                themeColor.withAlpha(100),
              ]),
              
            ),
            alignment: Alignment(0, 0.2),
            child: Text(
              '浅宇\nQianyuIm',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: e, fontSize: 16),
            ),
        ),
      )
    )
      )).toList(),
    );
  }
}

