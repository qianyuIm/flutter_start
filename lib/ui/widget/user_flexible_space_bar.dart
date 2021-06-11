import 'package:flutter/material.dart';
import 'dart:math' as math;

class UserFlexibleSpaceBar extends StatefulWidget {
  final Widget content;
  final Widget trickContent;
  const UserFlexibleSpaceBar(
      {Key? key, required this.content, required this.trickContent})
      : super(key: key);

  static Widget createSettings({
    double? toolbarOpacity,
    double? minExtent,
    double? maxExtent,
    required double currentExtent,
    required Widget child,
  }) {
    return FlexibleSpaceBarSettings(
      toolbarOpacity: toolbarOpacity ?? 1.0,
      minExtent: minExtent ?? currentExtent,
      maxExtent: maxExtent ?? currentExtent,
      currentExtent: currentExtent,
      child: child,
    );
  }

  @override
  _UserFlexibleSpaceBarState createState() => _UserFlexibleSpaceBarState();
}

class _UserFlexibleSpaceBarState extends State<UserFlexibleSpaceBar> {
  double _getCollapsePadding(double t, FlexibleSpaceBarSettings settings) {
    final double deltaExtent = settings.maxExtent - settings.minExtent;
    return -Tween<double>(begin: 0.0, end: deltaExtent / 4.0).transform(t);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final FlexibleSpaceBarSettings settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;
        assert(
          settings != null,
          'A FlexibleSpaceBar must be wrapped in the widget returned by FlexibleSpaceBar.createSettings().',
        );
        final List<Widget> children = <Widget>[];
        final double deltaExtent = settings.maxExtent - settings.minExtent;
        final double t =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0);

        final double fadeStart =
            math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
        const double fadeEnd = 1.0;
        assert(fadeStart <= fadeEnd);
        final double opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);
        double height = settings.maxExtent;

        children.add(Positioned(
          /// 向上偏移
          // top: _getCollapsePadding(t, settings),
          /// 固定写死
          top: 0.0,
          left: 0.0,
          right: 0.0,
          height: height,
          child: Opacity(
            // IOS is relying on this semantics node to correctly traverse
            // through the app bar when it is collapsed.
            alwaysIncludeSemantics: true,
            opacity: opacity,
            child: widget.trickContent,
          ),
        ));
        children.add(Container(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: widget.content,
        )));
        return ClipRect(
          child: Stack(
            children: children,
          ),
        );
      },
    );
  }
}
