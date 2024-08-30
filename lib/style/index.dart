library style;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TenScheme {
  //字体颜色
  static Color textLight = const Color(0xff1f2024);
  static Color textDark = const Color(0xffffffff);

  ///文本规范 - 标题
  ///一般文字不需要加样式
  static TextStyle h1 =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2 =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static TextStyle h3 =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static TextStyle h4 =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w800);

  /// 活动的 / 希望被关注到文字的 / [TenListItem]的标题
  static TextStyle action =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
  static TextStyle actionL =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
  static TextStyle actionM =
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
  static TextStyle actionS =
      const TextStyle(fontSize: 10, fontWeight: FontWeight.w600);

  /// 强调和说明性
  static TextStyle caption =
      const TextStyle(fontSize: 10, fontWeight: FontWeight.w600);

  /// 描述
  static TextStyle desction =
      const TextStyle(fontSize: 12, color: Color(0xff71727a));

  //主题色
  static Color primary = const Color(0xff006ffd);
  static Color primary50 = const Color(0xff2897ff);
  static Color primary100 = const Color(0xff6fbaff);
  static Color primary200 = const Color(0xffb4dbff);

  /// [TenAvatar] 头像背景色
  static Color primary300 = const Color(0xffeaf2ff);
  static Color primary300Opacity = primary300.withOpacity(0.4);

  ///中性色
  static Color neutralLight = const Color(0xffC5C6CC);

  /// 分割线
  static Color neutralLight50 = const Color(0xffD4D6DD);

  /// 一般卡片背景[TenTitle]
  static Color neutralLight100 = const Color(0xffE8E9F1);
  static Color neutralLight200 = const Color(0xffF8F9FE);

  static Color neutralDark = const Color(0xff1f2024);
  static Color neutralDark50 = const Color(0xff2f3036);
  static Color neutralDark100 = const Color(0xff494a50);
  static Color neutralDark200 = const Color(0xff71727a);

  //交互色
  static Color success = const Color(0xff298267);
  static Color successBackGroud = const Color(0xffe7f4e8);
  static Color wraning = const Color(0xffe86339);
  static Color wraningBackGroud = const Color(0xfffff4e4);
  static Color error = const Color(0xffed3241);
  static Color errorBackGroud = const Color(0xffffe2e5);

  void setScheme(Color customPrimary) {
    primary = customPrimary;
    primary50 = Color.lerp(primary, const Color(0xffffffff), 0.15)!; // 较浅的颜色
    primary100 = Color.lerp(primary, const Color(0xffffffff), 0.4)!;  // 更浅的颜色
    primary200 = Color.lerp(primary, const Color(0xffffffff), 0.65)!; // 最浅的颜色
    primary300 = Color.lerp(primary, const Color(0xffffffff), 0.85)!; // 最浅的颜色
    primary300Opacity = primary300.withOpacity(0.4);
  }
}
