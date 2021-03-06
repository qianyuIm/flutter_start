import 'package:flutter/material.dart';
import 'package:flutter_start/config/colors.dart';
import 'package:flutter_start/config/constant.dart';
import 'package:flutter_start/generated/l10n.dart';
import 'package:flutter_start/theme/theme_model.dart';
import 'package:flutter_start/ui/flutter/qy_expansion_tile.dart';
import 'package:flutter_start/ui/widget/circle.dart';
import 'package:flutter_start/ui/widget/feedback_widget.dart';
import 'package:provider/provider.dart';
// https://dev.to/himanshusharma89/flutter-how-to-scroll-an-expansiontile-when-it-is-expanded-2i2c
class ThemeColorSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).themeColorSettings),
      ),
      body: _buildThemeCell(
          context,
          ConstantUtil.themeColorSupport.keys.toList(),
          themeModel.themeColor,
          themeModel),
    );
  }

  Widget _buildThemeCell(
      BuildContext context,
      List<MaterialColor> themeColorSupport,
      MaterialColor themeColor,
      ThemeModel themeModel) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(top: 10),
        ),
        SliverToBoxAdapter(
          child: QYExpansionTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).darkMode),
                Text(ThemeModel.darkModeName(themeModel.darkModeIndex, context))
              ],
            ),
            leading: Icon(
              Icons.color_lens,
              color: Theme.of(context).accentColor,
            ),
            children: [
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: ConstantUtil.darkModeSupport.length,
                itemBuilder: (context, index) {
                  var themeModel =
                      Provider.of<ThemeModel>(context, listen: false);
                  return RadioListTile<int>(
                    activeColor: Theme.of(context).primaryColor,
                    selected: themeModel.darkModeIndex == index,
                    value: index,
                    onChanged: (value) {
                      themeModel.switchDarkMode(value);
                    },
                    groupValue: themeModel.darkModeIndex,
                    title: Text(ThemeModel.darkModeName(index, context)),
                  );
                },
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(top: 10),
        ),
        SliverGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.5,
          children: themeColorSupport.map((gridColor) {
            return FeedbackWidget(
              a: 0.95,
              duration: Duration(milliseconds: 200),
              onPressed: () {
                themeModel.switchTheme(color: gridColor);
              },
              child: GridTile(
                header: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: themeColor == gridColor
                          ? themeColor.withAlpha(100)
                          : themeColor.withAlpha(30)),
                  padding: EdgeInsets.only(left: 10, right: 5),
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
                      Text(
                        ColorUtil.colorString(gridColor),
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      if (gridColor == themeColor)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Circle(color: Colors.white),
                        )
                    ],
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(colors: [
                      gridColor[50]!,
                      gridColor[100]!,
                      gridColor[200]!,
                      gridColor[300]!,
                      gridColor[400]!,
                      gridColor[500]!,
                      gridColor[600]!,
                      gridColor[700]!,
                      gridColor[800]!,
                      gridColor[900]!,
                    ]),
                  ),
                  alignment: Alignment(0, 0.25),
                  child: Text(
                    ConstantUtil.themeColorSupport[gridColor] ?? "123",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
