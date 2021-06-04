import 'package:flutter/material.dart';

class TestPage1 extends StatefulWidget {
  @override
  _TestPage1State createState() => _TestPage1State();
}

class _TestPage1State extends State<TestPage1> {
  Widget box1() => SizedBox(
        height: 60,
        child: Container(
          color: Colors.red,
          child: Center(
            child: Text('底层listview1'),
          ),
        ),
      );
  Widget box2() => SizedBox(
        height: 90,
        child: Container(
          color: Colors.purple,
          child: Center(
            child: Text('底层listview2'),
          ),
        ),
      );
  Widget box3() => SizedBox(
        height: 160,
        child: Container(
          color: Colors.orange,
          child: Center(
            child: Text('底层listview3'),
          ),
        ),
      );
  Widget box4() {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 10,
          child: Container(
            width: 300,
            child: ListView.builder(
            // clipBehavior: Clip.none,
            shrinkWrap: true,
            itemCount: 20,
            // itemExtent: 50,
            itemBuilder: (context, index) {
              return Container(
                width: 300,
                height: 50,
                color: Colors.redAccent,
                child: Center(
                  child: Text('上层---$index'),
                ),
              );
            },
          ),
          )
        )
      ],
    );
  }

  late ScrollController _scrollController;
  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        children: [box1(), box2(), box3(), box4()],
      ),
    );
  }
}
