
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/config/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 影评列表页
 */
class MovieReviewsListPage extends StatefulWidget {
  final  movieId;
  final DrawerScrollListener scrollListener;

  MovieReviewsListPage(this.movieId, this.scrollListener, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MovieReviewsListState();
  }
}

class _MovieReviewsListState extends State<MovieReviewsListPage> {
  late ScrollController _scrollController;


  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if (widget.scrollListener != null) {
        widget.scrollListener(_scrollController.offset);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
              return _buildReviewsContent(context);

  }

  Widget _buildReviewsContent(BuildContext context) {
    return Container(
        color: Colors.white,
        child: RepaintBoundary(
            child: SmartRefresher(
          controller: _refreshController,
          footer: ClassicFooter(),
          enablePullDown: false,
          onLoading: () {
            
          },
          enablePullUp: true,
          child: ListView.builder(
              controller: _scrollController,
              addRepaintBoundaries: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return _buildCommendItem(context);
              }),
        )));
  }

  Widget _buildCommendItem(BuildContext context) {
    return Container(padding: EdgeInsets.only(top: 10),width: 100,height: 100,color: ColorUtil.random(),);
  }
}

typedef DrawerScrollListener = void Function(double offset);
