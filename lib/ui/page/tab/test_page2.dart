import 'package:flutter/material.dart';
import 'package:flutter_start/config/colors.dart';

class TestPage2 extends StatefulWidget {
  @override
  _TestPage2State createState() => _TestPage2State();
}

class _TestPage2State extends State<TestPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          print(innerBoxIsScrolled);
          return [
            SliverAppBar(
                title: Text('123'),
                expandedHeight: 200,
                pinned: true,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  // title: Text('456'),
                  background: Container(
                    color: Colors.purpleAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 414,
                          height: 100,
                          child: Stack(
                            children: [
                              Container(
                                width: 40,
                                height: 100,
                                color: Colors.red,
                              ),
                              Positioned(
                                right: 20,
                                child: Container(
                                width: 40,
                                height: 100,
                                color: Colors.black,
                              ),
                              ),
                              
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ))
          ];
        },
        body: Container(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 40,
            itemExtent: 50,
            itemBuilder: (context, index) {
              return Container(
                color: ColorUtil.random(),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('index -> $index'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
