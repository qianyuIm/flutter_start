import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/ui/page/specialEffects/douban/movie_reviews_list_page.dart';


/**
 * 电影详情页
 */
class MovieDetailPage extends StatefulWidget {
  final String movieId;

  MovieDetailPage(this.movieId);

  @override
  State<StatefulWidget> createState() {
    return MovieDetailState();
  }
}

late bool offstageAutorInfo;
late bool offstageTitle;

class MovieDetailState extends State<MovieDetailPage> {
  /// 主色
  Color _pageColor = Colors.orange;
  late ScrollController _bodyScrollController;


  @override
  void initState() {
    super.initState();
    offstageAutorInfo = true;
    offstageTitle = false;
    _bodyScrollController = ScrollController();
    _bodyScrollController.addListener(() {
      if (_bodyScrollController.offset > 150) {
        if (offstageAutorInfo) {
          offstageAutorInfo = false;
          offstageTitle = true;
          setState(() {});
        }
      } else {
        if (!offstageAutorInfo) {
          offstageAutorInfo = true;
          offstageTitle = false;
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    if(isDark) {
      _pageColor = Color(0xFF272727);
    }

    return Scaffold(
        appBar: AppBar(
          title: buildTitleBar(context),
          backgroundColor: _pageColor,
        ),
        backgroundColor: _pageColor,
        body: 

             BottomDrawerWidget( _bodyScrollController)
          
        );
  }

  Widget buildTitleBar(BuildContext context) {
    return Stack(
      children: <Widget>[
        Offstage(
          offstage: offstageTitle,
          child: Text(
            '电影',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Offstage(
          offstage: offstageAutorInfo,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 20,height: 40,),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '1212121212',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      
                    ],
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  
}

class BottomDrawerWidget extends StatefulWidget {
  ScrollController bodyScrollController;

  BottomDrawerWidget(this.bodyScrollController);

  @override
  State<StatefulWidget> createState() {
    return BottomDrawerState();
  }
}

class BottomDrawerState extends State<BottomDrawerWidget>
    with TickerProviderStateMixin {
  double drawerOffset = 0;
  double lastDrawerOffset = 0;
  double initDrawerOffset = 0;
 late  AnimationController offsetAnimalController;
  Animation<double>? offsetAnimation;
  double bodyScrollOffset = 0.0;
  double drawerScrollOffset = 0.0;
  bool isDrawerMoving = false;
  bool isDownInDrawerHeader = false;

  // BottomDrawerState();

  @override
  void initState() {
    super.initState();
    offsetAnimalController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    initDrawerOffset = drawerOffset = lastDrawerOffset =
        ScreenUtil().screenHeight - 100 - kToolbarHeight;
    widget.bodyScrollController.addListener(() {});
  }

  void updateDrawerOffset(double offset) {
    bool needRefreshUi = false;

    drawerOffset = offset;

    if (drawerOffset < 0) {
      drawerOffset = 0;
    }
    if (drawerOffset > initDrawerOffset) {
      drawerOffset = initDrawerOffset;
    }

    if (lastDrawerOffset != drawerOffset) {
      lastDrawerOffset = drawerOffset;
      needRefreshUi = true;
    }

    if (needRefreshUi) {
      //debugPrint("---------drawerOffset:${drawerOffset}");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: Stack(children: <Widget>[
        _buildBody(),
        _buildDrawer(),
      ]),
      onWillPop: () async {
        if (drawerOffset == 0) {
          _doDrawerOffsetAnim(0.0, initDrawerOffset);
          return false;
        }
        return true;
      },
    );
  }

  @override
  void dispose() {
    widget.bodyScrollController.dispose();
    super.dispose();
  }

  Widget _buildBody() {
    return Listener(
        onPointerUp: (event) {
          if (!isDrawerMoving && drawerOffset < initDrawerOffset) {
            double start = drawerOffset;
            double end = 0.0;
            if (drawerOffset >= initDrawerOffset / 2) {
              //drawer张开高度小于一半
              end = initDrawerOffset;
            }
            _doDrawerOffsetAnim(start, end);
          }
        },
        child: NotificationListener<OverscrollNotification>(
            onNotification: (OverscrollNotification notification) {
              //body到达边界,并且向上滑动
              if (notification.dragDetails != null) {
                debugPrint(
                    "------------notification.dragDetails:${notification.dragDetails!.delta.dy}");
                if (notification.dragDetails!.delta.dy < 0) {
                  double newDrawerOffset =
                      drawerOffset + notification.dragDetails!.delta.dy;
                  updateDrawerOffset(newDrawerOffset);
                }
              }
              return false;
            },
            child: ListView(
              controller: widget.bodyScrollController,
              children: <Widget>[
                Container(padding: EdgeInsets.only(top: 10),height: 100,width: 375,color: Colors.red,),
                Container(padding: EdgeInsets.only(top: 10),height: 100,width: 375,color: Colors.yellow,),
                Container(padding: EdgeInsets.only(top: 10),height: 500,width: 375,color: Colors.red,),
                Container(padding: EdgeInsets.only(top: 10),height: 100,width: 375,color: Colors.red,),
                Container(padding: EdgeInsets.only(top: 10),height: 100,width: 375,color: Colors.black,),
                Container(padding: EdgeInsets.only(top: 10),height: 400,width: 375,color: Colors.red,),
                Container(padding: EdgeInsets.only(top: 10),height: 100,width: 375,color: Colors.black,),

                // MovieDetailRatingWidget(widget.movieDetailVo),
                // MovieDetailTag(widget.movieDetailVo),
                // MovieDetailPlotWidget(widget.movieDetailVo),
                // MovieDetailStaffListWidget(widget.movieDetailVo),
                // MovieDetailStillsWidget(widget.movieDetailVo),
                // MovieDetailPopularCommentWidget(widget.movieDetailVo),
              ],
            )));
  }

  void _doDrawerOffsetAnim(double start, double end) {
    offsetAnimalController.reset();
    final CurvedAnimation curve =
        CurvedAnimation(parent: offsetAnimalController, curve: Curves.easeOut);
    offsetAnimation = Tween(begin: start, end: end).animate(curve)
      ..addListener(() {
        // updateDrawerOffset(offsetAnimation!.value);
      });

    ///自己滚动
    offsetAnimalController.forward();
  }

  Widget _buildDrawer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Listener(
        onPointerDown: (event) {
          isDownInDrawerHeader =
              event.localPosition.dy <= (drawerOffset + kToolbarHeight);
          debugPrint(
              "onPointerDown isDownInDrawerHeader:$isDownInDrawerHeader,localPosition.dy:${event.localPosition.dy},drawerOffset=${drawerOffset}");
        },
        onPointerMove: (event) {
          isDrawerMoving = true;
          if (isDownInDrawerHeader ||
              (drawerScrollOffset == 0 &&
                  event.delta.dy != 0 &&
                  drawerOffset <= initDrawerOffset)) {
            double newDrawerOffset = drawerOffset + event.delta.dy;
            updateDrawerOffset(newDrawerOffset);
          }
        },
        onPointerUp: (event) {
          debugPrint("onPointerUp...dy=${event.delta.dy}");
          isDrawerMoving = false;
          isDownInDrawerHeader = false;
          double start = drawerOffset;
          double end = 0;
          if (drawerOffset >= initDrawerOffset / 2) {
            //drawer张开高度小于一半
            end = initDrawerOffset;
          }
          _doDrawerOffsetAnim(start, end);
        },
        child: Transform.translate(
            offset: Offset(0.0, drawerOffset),
            child: Column(
              children: <Widget>[
                Container(
                    width: ScreenUtil().screenWidth,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color:Colors.blue,
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(10.0),
                          topRight: const Radius.circular(10.0)),
                    ),
                    height: kToolbarHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Text(
                            '12121212',
                          ),
                        ),
                        //Divider(height: 14, color: Color(0x66cccccc)),
                      ],
                    )),
                Expanded(
                  child:
                      MovieReviewsListPage('', (offset) {
                    debugPrint('drawerScrollOffset=$drawerScrollOffset');
                    drawerScrollOffset = offset;
                  }),
                )
              ],
            )),
      ),
    );
  }
}
