import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

extension WidgetShowExtension on Widget? {
  ///若Widget 不存在则渲染SizedBox，SizedBox 的性能开销可忽略不计
  Widget show() => this ?? const SizedBox();
}

extension WidgetCommonExtension on Widget {
  ///自动限制无限高度部件的最大高度，一般包裹Column
  Widget intrinsicHeight() => IntrinsicHeight(child: this);
  Widget intrinsicWidth() => IntrinsicWidth(child: this);

  ///让一个部件变为可滑动，使用SingleChildScrollView包裹仅此而已
  Widget scrollView() => SingleChildScrollView(child: this);

  ///让部件进入加载状态
  Widget withLoading(bool isLoading, {double? size}) {
    if (!isLoading) return this;
    return Stack(
      children: [
        Opacity(
          opacity: 0.48,
          child: this,
        ), // 原组件
        Positioned.fill(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: SizedBox(width: size,height: size,child:  CircularProgressIndicator(
                  color: TenScheme.primary,
                )), // 中间的加载指示器
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///为一个部件快速添加圆角
  Widget withClipRRect(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: this,
    );
  }

    Widget padding({double left = 0, double right = 0, double top = 0, double bottom = 0}) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: this,
    );
  }

  Widget paddingAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }
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

  List<Widget> withPadding(
      {double? size, double? horizontal, double? vertical}) {
    if (isEmpty) return this;
    horizontal = horizontal ?? size ?? 8;
    vertical = vertical ?? size ?? 8;
    List<Widget> result = [];
    for (var i = 0; i < length; i++) {
      result.add(Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this[i],
      ));
    }
    return result;
  }

  ///在列表中的每个 Widget 之间添加一个间隔
  List<Widget> withIntervals({double? wSize, double? hSize}) {
    if (isEmpty) return this;
    List<Widget> result = [];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(SizedBox(width: wSize, height: hSize));
      }
    }
    return result;
  }
}