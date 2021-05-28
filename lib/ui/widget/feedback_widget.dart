import 'package:flutter/material.dart';
import 'dart:math';

enum FeedMode {
  scale,
  fade,
  rotate,
}
/// 反馈 Widget
class FeedbackWidget extends StatefulWidget {
  final Widget child;
  final FeedMode mode;
  final Duration duration;
  final Function()? onPressed;
  final Function()? onEnd;
  final Function()? onLongPressed;
  final a;

  FeedbackWidget({
    required this.child,
    this.mode = FeedMode.scale,
    this.a = 0.9,
    this.onLongPressed,
    this.duration = const Duration(milliseconds: 150),
    this.onPressed,
    this.onEnd,
  });

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedbackWidget>
    with SingleTickerProviderStateMixin {
 late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          _controller.reverse().then((value) {
            if (widget.onEnd != null) widget.onEnd!();
          });
        }
      });
  }

  // 当父层状态执行 setState， 当前 State 不会执行 initState，而是 didUpdateWidget,
  // 因此如果上层状态对某些 widget 配置进行修改，那么当前状态对象便无法知晓，比如 duration 、
  // 如果配置不同了需要在 didUpdateWidget 回调中更新
  //
  @override
  void didUpdateWidget(FeedbackWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: widget.onLongPressed,
        onTap: () {
          _controller.forward();
          if (widget.onPressed != null) {
            widget.onPressed!();
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          child: widget.child,
          builder: (ctx, child) => _buildByMode(child, widget.mode),
        ));
  }

  Widget _buildByMode(Widget? child, FeedMode mode) {
    double rate = (widget.a - 1) * _controller.value + 1;
    switch (mode) {
      case FeedMode.scale:
        return Transform.scale(scale: rate, child: widget.child);
      case FeedMode.fade:
        return Opacity(opacity: rate, child: widget.child);
      case FeedMode.rotate:
        return Transform.rotate(angle: rate * pi * 2, child: widget.child);
    }
  }
}