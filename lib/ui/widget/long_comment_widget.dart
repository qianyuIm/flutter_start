import 'package:flutter/material.dart';


///电影长评论
class LongCommentWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LongCommentTabView();
  }
}

class LongCommentTabView extends StatefulWidget {

  

  @override
  _LongCommentTabViewState createState() => _LongCommentTabViewState();
}

class _LongCommentTabViewState extends State<LongCommentTabView>
    with SingleTickerProviderStateMixin {
  final List<String> list = ['影评', '话题', '讨论'];

  late TabController controller;
  late Color selectColor, unselectedColor;
  late TextStyle selectStyle, unselectedStyle;

  @override
  void initState() {
    controller = TabController(length: list.length, vsync: this);
    selectColor = Colors.black;
    unselectedColor = Color.fromARGB(255, 117, 117, 117);
    selectStyle = TextStyle(fontSize: 15, color: selectColor);
    unselectedStyle = TextStyle(fontSize: 15, color: selectColor);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 6.0,
          width: 45.0,
          margin: const EdgeInsets.only(top: 10.0),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 214, 215, 218),
              borderRadius: BorderRadius.all(const Radius.circular(5.0))),
        ),
        Container(
          padding: const EdgeInsets.only(top: 15.0),
          child: TabBar(
            tabs: list
                .map((item) => Padding(
                      padding:
                          const EdgeInsets.only(bottom: 8.0),
                      child: Text(item),
                    ))
                .toList(),
            isScrollable: true,
            indicatorColor: selectColor,
            labelColor: selectColor,
            labelStyle: selectStyle,
            unselectedLabelColor: unselectedColor,
            unselectedLabelStyle: unselectedStyle,
            indicatorSize: TabBarIndicatorSize.label,
            controller: controller,
          ),
          alignment: Alignment.centerLeft,
        ),
        Expanded(
            child: TabBarView(
          children: <Widget>[
            ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      child: Container(color: Colors.purple,),
                      padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0),
                      color: Colors.white,
                    ),
                    Container(
                      height: 10.0,
                      color: Colors.transparent,
                    )
                  ],
                );
              },
              physics: const ClampingScrollPhysics(),
              itemCount: 10,
            ),
            Text('话题，暂无数据~'),
            Text('讨论，暂无数据~')
          ],
          controller: controller,
        ))
      ],
    );
  }


  
  ///将34123转成3.4k
  getUsefulCount(int usefulCount) {
    double a = usefulCount / 1000;
    if (a < 1.0) {
      return usefulCount;
    } else {
      return '${a.toStringAsFixed(1)}k'; //保留一位小数
    }
  }
}
