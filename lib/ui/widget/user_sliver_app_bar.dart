import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:flutter_start/ui/widget/user_flexible_space_bar.dart';

/// 修改 SliverAppBar 源码
class UserSliverAppBar extends StatefulWidget {
  final bool stretch;
  final double expandedHeight;
  final bool pinned;
  final Widget flexibleSpace;
  final Widget? leading;
  final List<Widget>? actions;

  const UserSliverAppBar(
      {Key? key,
      this.leading,
      required this.expandedHeight,
      this.pinned = true,
      this.stretch = true,
      required this.flexibleSpace,
      this.actions})
      : super(key: key);
  @override
  _UserSliverAppBarState createState() => _UserSliverAppBarState();

}

class _UserSliverAppBarState extends State<UserSliverAppBar>  with TickerProviderStateMixin {
  OverScrollHeaderStretchConfiguration? _stretchConfiguration;

  void _updateStretchConfiguration() {
    if (widget.stretch) {
      _stretchConfiguration = OverScrollHeaderStretchConfiguration();
    } else {
      _stretchConfiguration = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _updateStretchConfiguration();
  }

  @override
  void didUpdateWidget(UserSliverAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.stretch != oldWidget.stretch) {
      _updateStretchConfiguration();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double bottomHeight =  0.0;
    final double topPadding =  MediaQuery.of(context).padding.top;
    final double collapsedHeight = kToolbarHeight + bottomHeight + topPadding;

    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: SliverPersistentHeader(
        floating: false,
        pinned: widget.pinned,
        delegate: _UserSliverAppBarDelegate(
          vsync: this,
          leading: widget.leading,
          automaticallyImplyLeading: true,
          title: null,
          actions: widget.actions,
          flexibleSpace: widget.flexibleSpace,
          bottom: null,
          elevation: 0,
          shadowColor: null,
          forceElevated: false,
          backgroundColor: null,
          foregroundColor: null,
          brightness: null,
          iconTheme: null,
          actionsIconTheme: null,
          textTheme: null,
          primary: true,
          centerTitle: true,
          excludeHeaderSemantics: false,
          titleSpacing: 0,
          expandedHeight: widget.expandedHeight,
          collapsedHeight: collapsedHeight,
          topPadding: topPadding,
          floating: false,
          pinned: widget.pinned,
          shape: null,
          snapConfiguration: null,
          stretchConfiguration: _stretchConfiguration,
          showOnScreenConfiguration: null,
          toolbarHeight: kToolbarHeight,
          leadingWidth: null,
          backwardsCompatibility: false,
          toolbarTextStyle: null,
          titleTextStyle: null,
          systemOverlayStyle: null,

        ),
      ),
    );
  }
}


class _UserSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _UserSliverAppBarDelegate({
    required this.leading,
    required this.automaticallyImplyLeading,
    required this.title,
    required this.actions,
    required this.flexibleSpace,
    required this.bottom,
    required this.elevation,
    required this.shadowColor,
    required this.forceElevated,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.brightness,
    required this.iconTheme,
    required this.actionsIconTheme,
    required this.textTheme,
    required this.primary,
    required this.centerTitle,
    required this.excludeHeaderSemantics,
    required this.titleSpacing,
    required this.expandedHeight,
    required this.collapsedHeight,
    required this.topPadding,
    required this.floating,
    required this.pinned,
    required this.vsync,
    required this.snapConfiguration,
    required this.stretchConfiguration,
    required this.showOnScreenConfiguration,
    required this.shape,
    required this.toolbarHeight,
    required this.leadingWidth,
    required this.backwardsCompatibility,
    required this.toolbarTextStyle,
    required this.titleTextStyle,
    required this.systemOverlayStyle,
  }) : assert(primary || topPadding == 0.0),
       assert(
         !floating || (snapConfiguration == null && showOnScreenConfiguration == null) || vsync != null,
         'vsync cannot be null when snapConfiguration or showOnScreenConfiguration is not null, and floating is true',
       ),
       _bottomHeight = bottom?.preferredSize.height ?? 0.0;

  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final Color? shadowColor;
  final bool forceElevated;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Brightness? brightness;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final TextTheme? textTheme;
  final bool primary;
  final bool? centerTitle;
  final bool excludeHeaderSemantics;
  final double? titleSpacing;
  final double? expandedHeight;
  final double collapsedHeight;
  final double topPadding;
  final bool floating;
  final bool pinned;
  final ShapeBorder? shape;
  final double? toolbarHeight;
  final double? leadingWidth;
  final bool? backwardsCompatibility;
  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final double _bottomHeight;

  @override
  double get minExtent => collapsedHeight;

  @override
  double get maxExtent => math.max(topPadding + (expandedHeight ?? (toolbarHeight ?? kToolbarHeight) + _bottomHeight), minExtent);

  @override
  final TickerProvider vsync;

  @override
  final FloatingHeaderSnapConfiguration? snapConfiguration;

  @override
  final OverScrollHeaderStretchConfiguration? stretchConfiguration;

  @override
  final PersistentHeaderShowOnScreenConfiguration? showOnScreenConfiguration;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double visibleMainHeight = maxExtent - shrinkOffset - topPadding;
    final double extraToolbarHeight = math.max(minExtent - _bottomHeight - topPadding - (toolbarHeight ?? kToolbarHeight), 0.0);
    final double visibleToolbarHeight = visibleMainHeight - _bottomHeight - extraToolbarHeight;

    final bool isPinnedWithOpacityFade = pinned && floating && bottom != null && extraToolbarHeight == 0.0;
    final double toolbarOpacity = !pinned || isPinnedWithOpacityFade
      ? (visibleToolbarHeight / (toolbarHeight ?? kToolbarHeight)).clamp(0.0, 1.0)
      : 1.0;

    final Widget appBar = UserFlexibleSpaceBar.createSettings(
      minExtent: minExtent,
      maxExtent: maxExtent,
      currentExtent: math.max(minExtent, maxExtent - shrinkOffset),
      toolbarOpacity: toolbarOpacity,
      child: AppBar(
        leading: leading,
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: title,
        actions: actions,
        flexibleSpace: (title == null && flexibleSpace != null && !excludeHeaderSemantics)
          ? Semantics(child: flexibleSpace, header: true)
          : flexibleSpace,
        bottom: bottom,
        elevation: forceElevated || overlapsContent || (pinned && shrinkOffset > maxExtent - minExtent) ? elevation : 0.0,
        shadowColor: shadowColor,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        brightness: brightness,
        iconTheme: iconTheme,
        actionsIconTheme: actionsIconTheme,
        textTheme: textTheme,
        primary: primary,
        centerTitle: centerTitle,
        excludeHeaderSemantics: excludeHeaderSemantics,
        titleSpacing: titleSpacing,
        shape: shape,
        toolbarOpacity: toolbarOpacity,
        bottomOpacity: pinned ? 1.0 : ((visibleMainHeight / _bottomHeight).clamp(0.0, 1.0)),
        toolbarHeight: toolbarHeight,
        leadingWidth: leadingWidth,
        backwardsCompatibility: backwardsCompatibility,
        toolbarTextStyle: toolbarTextStyle,
        titleTextStyle: titleTextStyle,
        systemOverlayStyle: systemOverlayStyle,
      ),
    );
    return appBar;
  }

  @override
  bool shouldRebuild(_UserSliverAppBarDelegate oldDelegate) {
    return leading != oldDelegate.leading
        || automaticallyImplyLeading != oldDelegate.automaticallyImplyLeading
        || title != oldDelegate.title
        || actions != oldDelegate.actions
        || flexibleSpace != oldDelegate.flexibleSpace
        || bottom != oldDelegate.bottom
        || _bottomHeight != oldDelegate._bottomHeight
        || elevation != oldDelegate.elevation
        || shadowColor != oldDelegate.shadowColor
        || backgroundColor != oldDelegate.backgroundColor
        || foregroundColor != oldDelegate.foregroundColor
        || brightness != oldDelegate.brightness
        || iconTheme != oldDelegate.iconTheme
        || actionsIconTheme != oldDelegate.actionsIconTheme
        || textTheme != oldDelegate.textTheme
        || primary != oldDelegate.primary
        || centerTitle != oldDelegate.centerTitle
        || titleSpacing != oldDelegate.titleSpacing
        || expandedHeight != oldDelegate.expandedHeight
        || topPadding != oldDelegate.topPadding
        || pinned != oldDelegate.pinned
        || floating != oldDelegate.floating
        || vsync != oldDelegate.vsync
        || snapConfiguration != oldDelegate.snapConfiguration
        || stretchConfiguration != oldDelegate.stretchConfiguration
        || showOnScreenConfiguration != oldDelegate.showOnScreenConfiguration
        || forceElevated != oldDelegate.forceElevated
        || toolbarHeight != oldDelegate.toolbarHeight
        || leadingWidth != oldDelegate.leadingWidth
        || backwardsCompatibility != oldDelegate.backwardsCompatibility
        || toolbarTextStyle != oldDelegate.toolbarTextStyle
        || titleTextStyle != oldDelegate.titleTextStyle
        || systemOverlayStyle != oldDelegate.systemOverlayStyle;
  }

  @override
  String toString() {
    return '${describeIdentity(this)}(topPadding: ${topPadding.toStringAsFixed(1)}, bottomHeight: ${_bottomHeight.toStringAsFixed(1)}, ...)';
  }
}