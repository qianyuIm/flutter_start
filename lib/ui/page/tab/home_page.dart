
import 'package:flutter/material.dart';
import 'package:flutter_start/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    double w = 375.w;
  double h = 165.h;
    double hh = 165.w;

  print('width = $w, height = $h, hh = $hh');
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).tabHome),
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
