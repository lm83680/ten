import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

/// 仿写 ListTile , 仅保留常用的属性, 为了保持布局达到预期（顶中中），继承StatefulWidget用于计算部件
///
/// 若你的 ListTile 布局可接受 前中后段均居中的布局，尝试调用[TenListItemStl]
class TenListItem extends StatefulWidget {
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
  State<TenListItem> createState() => _TenListItemState();
}

class _TenListItemState extends State<TenListItem> {
  ///如果左侧图标高度大于文字高度，将使用居中布局
  final GlobalKey _key1 = GlobalKey();
  final GlobalKey _key2 = GlobalKey();
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center;

  @override
  void initState() {
    super.initState();
    if (widget.leading != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _calculateMinHeight();
      });
    }
  }

  void _calculateMinHeight() {
    final height1 = _key1.currentContext?.size?.height ?? 0.0;
    final height2 = _key2.currentContext?.size?.height ?? 0.0;
    setState(() {
      crossAxisAlignment = height2 > height1
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            if (widget.leading != null)
              SizedBox(key: _key1, child: widget.leading!.padding(right: 16)),
            Expanded(
                child: Row(
              key: _key2,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title, style: TenScheme.action),
                      if (widget.subtitle != null)
                        Text(
                          widget.subtitle!,
                          softWrap: true, // 允许换行
                          overflow: TextOverflow.ellipsis,
                          maxLines: widget.maxLines,
                          style: TenScheme.desction,
                        ).padding(top: 4)
                    ],
                  ),
                ),
                if (widget.trailing != null) widget.trailing!.padding(left: 16),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

///继承自StatelessWidget的ListTile，去掉计算开销，布局均居中
class TenListItemStl extends StatelessWidget {
  const TenListItemStl(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leading != null) leading!.padding(right: 16),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: Column(
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
                  ),
                ),
                if (trailing != null) trailing!.padding(left: 16),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
