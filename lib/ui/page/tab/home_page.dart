
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: ListView.builder(
        itemCount: 40,
        itemExtent: 40,
        itemBuilder: (context, index) {
          return Text("index = $index");
        },
      )
    
        
    );
    
  }
}
