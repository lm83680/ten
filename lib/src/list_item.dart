import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

/// 仿写 ListTile , 仅保留常用的属性
class TenListItem extends StatelessWidget {
  const TenListItem(
      {this.leading,
      required this.title,
      this.subtitle,
      this.trailing,
      this.maxLines = 3,
      this.onTap,
      this.onLongPress,
      super.key});
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final int maxLines;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (leading != null) leading!.padding(right: 16),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TenScheme.action),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        softWrap: true, // 允许换行
                        overflow: TextOverflow.ellipsis,
                        maxLines: maxLines,
                        style: TenScheme.desction,
                      ).padding(top: 4)
                  ],
                ))
              ],
            )),
            if (trailing != null) trailing!.padding(left: 16),
          ],
        ),
      ),
    );
  }
}
