import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class TenTag extends StatelessWidget {
  const TenTag(this.text,
      {this.onTap,
      this.onLongPress,
      this.lefticon,
      this.righticon,
      this.backgorundColor,
      this.plain,
      super.key});

  TenTag.success(this.text,
      {this.onTap, this.onLongPress, this.lefticon, this.righticon,this.plain, super.key})
      : backgorundColor = TenScheme.success;
  TenTag.wraning(this.text,
      {this.onTap, this.onLongPress, this.lefticon, this.righticon,this.plain,  super.key})
      : backgorundColor = TenScheme.wraning;
  TenTag.error(this.text,
      {this.onTap, this.onLongPress, this.lefticon, this.righticon,this.plain,  super.key})
      : backgorundColor = TenScheme.error;

  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final String text;
  final Widget? lefticon;
  final Widget? righticon;
  final Color? backgorundColor;
  ///朴素按钮 /文字颜色为backgorundColor，背景为融合0.65的纯白色
  final bool? plain;
  @override
  Widget build(BuildContext context) {
    Color bgcolor = plain == true ? (backgorundColor ?? TenScheme.primary).plain() : (backgorundColor ?? TenScheme.primary);
    Color textColor = plain == true ?  (backgorundColor ?? TenScheme.primary) : Colors.white;
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: bgcolor,
      ),
      child: Row(
        children: [
          if (lefticon != null) lefticon!.padding(right: 8),
          Text(text, style: TenScheme.actionM.copyWith(color: textColor,height: 1)),
          if (righticon != null) righticon!.padding(left: 8),
        ],
      ),
    ),
    ).intrinsicWidth();
  }
}
