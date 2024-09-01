import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class TenButton extends StatelessWidget {
  const TenButton(this.text,
      {this.onTap,
      this.onLongPress,
      this.lefticon,
      this.righticon,
      this.backgorundColor,
      super.key});

  TenButton.success(this.text,
      {this.onTap, this.onLongPress, this.lefticon, this.righticon, super.key})
      : backgorundColor = TenScheme.success;
  TenButton.wraning(this.text,
      {this.onTap, this.onLongPress, this.lefticon, this.righticon, super.key})
      : backgorundColor = TenScheme.wraning;
  TenButton.error(this.text,
      {this.onTap, this.onLongPress, this.lefticon, this.righticon, super.key})
      : backgorundColor = TenScheme.error;

  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final String text;
  final Widget? lefticon;
  final Widget? righticon;
  final Color? backgorundColor;

  @override
  Widget build(BuildContext context) {
    BorderRadius radius = BorderRadius.circular(12);
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12);

    return ClipRRect(
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: Material(
            child: InkWell(
                onTap: onTap,
                onLongPress: onLongPress,
                child: Ink(
                    padding: padding,
                    color: onTap == null && onLongPress == null
                        ? TenScheme.neutralLight
                        : backgorundColor ?? TenScheme.primary,
                    child: IconTheme(
                      data: IconThemeData(color: TenScheme.primary, size: 16),
                      child: Row(
                        children: [
                          if (lefticon != null) lefticon!.padding(right: 8),
                          Text(text,
                              style: TenScheme.action.copyWith(color: Colors.white,height: 1)),
                          if (righticon != null) righticon!.padding(left: 8),
                        ],
                      ),
                    )))));
  }
}

class TenButtonBorder extends StatelessWidget {
  const TenButtonBorder(this.text,
      {this.onTap,
      this.onLongPress,
      this.lefticon,
      this.righticon,
      this.borderColor,
      super.key});

  TenButtonBorder.success(this.text,
      {this.onTap, this.onLongPress, this.lefticon, this.righticon, super.key})
      : borderColor = TenScheme.success;
  TenButtonBorder.wraning(this.text,
      {this.onTap, this.onLongPress, this.lefticon, this.righticon, super.key})
      : borderColor = TenScheme.wraning;
  TenButtonBorder.error(this.text,
      {this.onTap, this.onLongPress, this.lefticon, this.righticon, super.key})
      : borderColor = TenScheme.error;

  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final String text;
  final Widget? lefticon;
  final Widget? righticon;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    Color color = onTap == null && onLongPress == null
        ? TenScheme.neutralLight
        : borderColor ?? TenScheme.primary;
    BorderRadius radius = BorderRadius.circular(12);
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
    return InkWell(
      onTap: onTap,
      borderRadius: radius,
      onLongPress: onLongPress,
      splashColor: color.withOpacity(0.4),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
            border: Border.all(color: color.withOpacity(0.6), width: 1),
            borderRadius: radius),
        child: IconTheme(
            data: IconThemeData(color: TenScheme.primary, size: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (lefticon != null) lefticon!.padding(right: 8),
                Text(text, style: TenScheme.action.copyWith(color: color,height: 1)),
                if (righticon != null) righticon!.padding(left: 8),
              ],
            )),
      ),
    );
  }
}

class TenButtonText extends StatelessWidget {
  const TenButtonText(this.text,
      {this.onTap,
      this.onLongPress,
      this.textColor,
      super.key,
      this.lefticon,
      this.righticon});

  TenButtonText.success(this.text,
      {this.onTap, this.onLongPress, super.key, this.lefticon, this.righticon})
      : textColor = TenScheme.success;
  TenButtonText.wraning(this.text,
      {this.onTap, this.onLongPress, super.key, this.lefticon, this.righticon})
      : textColor = TenScheme.wraning;
  TenButtonText.error(this.text,
      {this.onTap, this.onLongPress, super.key, this.lefticon, this.righticon})
      : textColor = TenScheme.error;

  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final String text;
  final Color? textColor;

  final Widget? lefticon;
  final Widget? righticon;

  @override
  Widget build(BuildContext context) {
    Color color = onTap == null && onLongPress == null
        ? TenScheme.neutralLight
        : textColor ?? TenScheme.primary;
    BorderRadius radius = BorderRadius.circular(12);
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
    return InkWell(
      onTap: onTap,
      borderRadius: radius,
      onLongPress: onLongPress,
      splashColor: color.withOpacity(0.4),
      child: Container(
          padding: padding,
          decoration: BoxDecoration(borderRadius: radius),
          child: IconTheme(
            data: IconThemeData(color: color),
            child:Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (lefticon != null) lefticon!.padding(right: 4),
              Text(text, style: TenScheme.action.copyWith(color: color,height: 1)),
              if (righticon != null) righticon!.padding(left: 4),
            ],
          ))),
    );
  }
}
