import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class TenCard extends StatelessWidget {
  const TenCard({required this.child, this.padding, this.margin, super.key});

  // 命名构造函数
  TenCard.column(
      {required List<Widget> children,
      crossAxisAlignment,
      this.padding,
      this.margin,
      super.key})
      : child = Column(
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: children,
        );

  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: margin ?? const EdgeInsets.all(16),
        child: Ink(
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: TenScheme.neutralLight200,
              borderRadius: BorderRadius.circular(16)),
          child: child,
        ));
  }
}
