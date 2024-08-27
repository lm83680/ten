import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

extension WidgetShowExtension on Widget? {
  ///若Widget 不存在则渲染SizedBox，SizedBox 的性能开销可忽略不计
  Widget show() => this ?? const SizedBox();
}

extension WidgetIntrinsicHeightExtension on Widget {
  ///自动限制无限高度部件的最大高度，一般包裹Column
  Widget intrinsicHeight() => IntrinsicHeight(child: this);
}

extension WidgetListExtensions on List<Widget> {
  ///在列表中的每个 Widget 之间添加一个分隔符,默认使用TenDivider
  List<Widget> withSeparator({Widget? separator}) {
    if (isEmpty) return this;
    Widget tseparator = separator ?? const TenDivider();
    List<Widget> result = [];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(tseparator);
      }
    }
    return result;
  }
}
