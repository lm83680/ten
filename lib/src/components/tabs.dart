import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ten/style/index.dart';

///TenTabs 只承担控制TabBar样式 
class TenTabs extends StatelessWidget implements PreferredSizeWidget {
  const TenTabs({
    super.key,
    required this.tabs,
    this.isScrollable,
    this.controller,
    this.onTap
  });
  final List<Widget> tabs;
  final double _kTabHeight = 46.0;
  final double indicatorWeight  = 2.0;
  final bool? isScrollable;
  final TabController? controller;
  final void Function(int)? onTap;
  @override
  Size get preferredSize {
    double maxHeight = _kTabHeight;
    for (final Widget item in tabs) {
      if (item is PreferredSizeWidget) {
        final double itemHeight = item.preferredSize.height;
        maxHeight = math.max(itemHeight, maxHeight);
      }
    }
    return Size.fromHeight(maxHeight + indicatorWeight);
  }

  @override
  Widget build(BuildContext context) {
    bool scrollable = isScrollable!=null ? isScrollable! : (tabs.length > 4 ? true:false);
    return TabBar(
      isScrollable: scrollable,
      controller: controller,
      unselectedLabelColor: TenScheme.neutralLight,
      labelColor: TenScheme.textLight,
      labelStyle: TenScheme.action,
      overlayColor: WidgetStateColor.transparent,
      indicatorColor: TenScheme.primary,
      dividerHeight: 1,
      dividerColor: TenScheme.neutralLight200,
      tabs: tabs,
      onTap: onTap,
    );
  }
}
