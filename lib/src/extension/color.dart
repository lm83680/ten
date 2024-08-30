import 'package:flutter/material.dart';

extension ColorsExtension on Color {
  ///将一个颜色变为朴素色 —— 混合 0.85 的纯白色
  Color plain() => Color.lerp(this, const Color(0xffffffff), 0.85)!;
}