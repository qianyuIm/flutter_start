import 'package:flutter/material.dart';

class NoAnimRouteBuilder extends PageRouteBuilder {
  final Widget page;
  NoAnimRouteBuilder(this.page)
      : super(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: Duration(milliseconds: 0),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) => child);
}

class Left2RightRouter extends PageRouteBuilder {
  final Widget child;
  final int durationMs;
  final Curve curve;
  Left2RightRouter(this.child,
      {this.durationMs = 500, this.curve = Curves.fastOutSlowIn})
      : super(
          transitionDuration: Duration(milliseconds: durationMs),
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
                  .animate(CurvedAnimation(parent: animation, curve: curve)),
              child: child,
            );
          },
        );
}
