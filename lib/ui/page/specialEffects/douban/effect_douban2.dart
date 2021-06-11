import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EffectDouBanPage2 extends StatefulWidget {
  @override
  _EffectDouBanPage2State createState() => _EffectDouBanPage2State();
}

class _EffectDouBanPage2State extends State<EffectDouBanPage2> {
  PanelController panel = new PanelController();
  double offsetDistance = 0.0;
  double offsetY = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SlidingUpPanel(
        controller: panel,
        minHeight: 40,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        body: GestureDetector(
          child: new ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Container(
                color: Colors.red,
              )),
          onTap: () {
            panel.close();
          },
          onVerticalDragDown: (details) {
            // print(details.globalPosition.dy);
            offsetDistance = details.globalPosition.dy;
          },
          onVerticalDragUpdate: (details) {
            offsetY = details.globalPosition.dy - offsetDistance;
            if (offsetY > 0) {
              print("向下" + offsetY.toString());
            } else {
              print("向上" + offsetY.toString());
              double position = offsetY.abs() / 300;
              position = position > 1 ? 1 : position;
              panel.panelPosition = position;
              if (position > 0.4) {
                // panel.open();
              }
            }
          },
        ),
        panel: Container(
          child: Center(
            child: Text("评论区",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none)),
          ),
        ),
      ),
    );
  }
}
