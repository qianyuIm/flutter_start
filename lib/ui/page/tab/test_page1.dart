import 'package:flutter/material.dart';
import 'package:flutter_start/ui/widget/bottom_drag_widget.dart';
import 'package:flutter_start/ui/widget/long_comment_widget.dart';

class TestPage1 extends StatefulWidget {
  @override
  _TestPage1State createState() => _TestPage1State();
}

class _TestPage1State extends State<TestPage1> {
  @override
  void initState() {
    super.initState();
  }

  double get screenH => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        body: Container(
          child: SafeArea(
              child: BottomDragWidget(
                  body: _getBody(),
                  dragContainer: DragContainer(
                      drawer: Container(
                        child: OverscrollNotificationWidget(
                          child: LongCommentWidget(),
                        ),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 243, 244, 248),
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(10.0),
                                topRight: const Radius.circular(10.0))),
                      ),
                      defaultShowHeight: screenH * 0.2,
                      height: screenH * 0.8))),
        ));
  }
}

Widget _getBody() {
  return CustomScrollView(
    physics: const BouncingScrollPhysics(),
    slivers: [
      SliverAppBar(
        title: Text('电影'),
        centerTitle: true,
        pinned: true,
        backgroundColor: Colors.white,
      ),
      SliverToBoxAdapter(
        child: Container(
          color: Colors.orange,
          height: 400,
        ),
      ),
      SliverToBoxAdapter(
        child: Stack(
          children: [
            Container(
          color: Colors.purple,
          height: 100,
        ),
         Positioned(
           top: 100,
           child: Container(
          color: Colors.black,
          height: 200,
        ),
         )
          ],
        )
      ),
      SliverToBoxAdapter(
        child: Container(
          color: Colors.orange,
          height: 400,
        ),
      )
    ],
  );
}
