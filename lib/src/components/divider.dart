import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class TenDivider extends StatelessWidget {
  final double thickness;
  final double indent;
  final double mtop;
  final double mbottom;
  final Color? color;
  final bool vertical;

  const TenDivider({
    super.key,
    this.thickness = 1.0,
    this.mtop = 0.0,
    this.mbottom = 0.0,
    this.indent = 0.0,
    this.vertical = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    Color tcolor = color ?? TenScheme.neutralLight100;
    return Container(
      margin: EdgeInsetsDirectional.only(
          start: indent, end: indent, top: mtop, bottom: mbottom),
      height: !vertical ? thickness : double.infinity,
      width: vertical ? thickness : double.infinity,
      color: tcolor,
    );
  }
}
