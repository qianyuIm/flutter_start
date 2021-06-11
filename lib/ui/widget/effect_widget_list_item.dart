import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_start/config/inch.dart';
import 'package:flutter_start/model/effect_model.dart';
import 'package:flutter_start/theme/theme_model.dart';
import 'package:flutter_start/ui/widget/circle_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class EffectWidgetListItem extends StatelessWidget {
  final EffectItemModel data;
  final bool hasTopHole;
  final bool hasBottomHole;

  const EffectWidgetListItem(
      {Key? key,
      required this.data,
      this.hasTopHole = true,
      this.hasBottomHole = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          bottom: 10, top: 2, left: Inchs.leftMargin, right: Inchs.rightMargin),
      child: Stack(
        children: [
          ClipPath(
            clipper: ShapeBorderClipper(
              shape: EffectShapeBorder(
                hasTopHole: hasTopHole,
                hasBottomHole: hasBottomHole,
                hasLine: false,
                edgeRadius: 20,
                lineRate: 0.2,
              )
            ),
            child: _buildContent(context),
          )
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) => Container(
        height: 95,
        color: Theme.of(context).primaryColor.withAlpha(100),
        padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
        child: Row(
          children: [
            buildLeading(context),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(context),
                  _buildSummary(context)
                ],
              ),
            )
          ],
        ),
      );
  Widget buildLeading(BuildContext context) => Padding(
        padding: EdgeInsets.all(6),
        child: Material(
          color: Colors.transparent,
          child: CircleText(
            text: data.name,
            size: 60,
            color: Theme.of(context).primaryColor.withAlpha(80),
            backgroundColor: Theme.of(context).primaryColor.withAlpha(30),
          ),
        ),
      );
  Widget _buildTitle(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          const SizedBox(width: 10),
          Expanded(
            child: Text(data.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: Provider.of<ThemeModel>(context, listen: false)
                        .fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decorationThickness: 2,
                    shadows: [
                      Shadow(color: Colors.white, offset: Offset(.3, .3))
                    ])),
          ),
          RatingBarIndicator(
            rating: data.lever,
            itemCount: data.lever.toInt(),
            itemSize: 15,
            itemBuilder: (BuildContext context, int index) {
              return Icon(
                Icons.star,
                color: Theme.of(context).primaryColor,
              );
            },
          ),
        ],
      ),
    );
  }

   Widget _buildSummary(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10, top: 5),
      child: Container(
        child: Text(
          //尾部摘要
          data.info,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.grey[600], fontSize: 14, shadows: [
            const Shadow(color: Colors.white, offset: const Offset(.5, .5))
          ]),
        ),
      ),
    );
  }
}


class EffectShapeBorder extends ShapeBorder {
  final int holeCount;
  final double lineRate;
  final bool dash;
  final bool hasLine;
  final Color color;
  final bool hasTopHole;
  final bool hasBottomHole;
  final double? edgeRadius;

  EffectShapeBorder(
      {this.holeCount = 6,
        this.hasTopHole =true,
        this.hasBottomHole =false,
      this.lineRate = 0.718,
      this.dash = true,
      this.hasLine = true,
      this.color = Colors.red,this.edgeRadius});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    double w = rect.width;
    double h = rect.height;

    double d = h / (1 + 2 * holeCount);

    Path path = Path();
    path.addRect(rect);

    _formHoldLeft(path, d);

    _formHoldRight(path, w, d);
    if (hasLine) {
      _formHoleTop(path, rect, d);
      _formHoleBottom(path, rect, d);
    }
    if(edgeRadius!=null){
      if(hasTopHole){
        _formHoleTop(path, rect, edgeRadius!);
      }
      if(hasBottomHole){
        _formHoleBottom(path, rect, edgeRadius!);
      }

    }
    path.fillType = PathFillType.evenOdd;

    return path;
  }

  void _formHoleBottom(Path path, Rect rect, double d) {
    path.addArc(
        Rect.fromCenter(
            center: Offset(lineRate * rect.width, rect.height),
            width: d,
            height: d),
        pi,
        pi);
  }

  void _formHoleTop(Path path, Rect rect, double d) {
    path.addArc(
        Rect.fromCenter(
            center: Offset(lineRate * rect.width, 0), width: d, height: d),
        0,
        pi);
  }

  _formHoldLeft(Path path, double d) {
    for (int i = 0; i < holeCount; i++) {
      double left = -d / 2;
      double top = 0.0 + d + 2 * d * (i);
      double right = left + d;
      double bottom = top + d;
      path.addArc(Rect.fromLTRB(left, top, right, bottom), -pi / 2, pi);
    }
  }

  _formHoldRight(Path path, double w, double d) {
    for (int i = 0; i < holeCount; i++) {
      double left = -d / 2 + w;
      double top = 0.0 + d + 2 * d * (i);
      double right = left + d;
      double bottom = top + d;
      path.addArc(Rect.fromLTRB(left, top, right, bottom), pi / 2, pi);
    }
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if(!hasLine) return;
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    double d = rect.height / (1 + 2 * holeCount);
    if (dash) {
      _drawDashLine(canvas, Offset(lineRate * rect.width, d / 2),
          rect.height / 16, rect.height - 13, paint);
    } else {
      canvas.drawLine(Offset(lineRate * rect.width, d / 2),
          Offset(lineRate * rect.width, rect.height - d / 2), paint);
    }
  }

  _drawDashLine(
      Canvas canvas, Offset start, double count, double length, Paint paint) {
    double step = length / count / 2;
    for (int i = 0; i < count; i++) {
      Offset offset = start + Offset(0, 2 * step * i);
      canvas.drawLine(offset, offset + Offset(0, step), paint);
    }
  }

  @override
  ShapeBorder scale(double t) {
    throw UnimplementedError();
  }
}
