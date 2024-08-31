import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

///Tile 系列 
///包含基本的 ListITile、 CheckboxListTile、 RadioListTile、SwitchListTile、ExpansionTile


/// 仿写 ListTile , 仅保留常用的属性, 为了保持布局达到预期（顶中中），继承StatefulWidget用于计算部件
/// 
/// CheckboxListTile、 RadioListTile、SwitchListTile 都将依赖此部件
class TenListITile extends StatefulWidget {
  const TenListITile(
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
  State<TenListITile> createState() => _TenListITileState();
}

class _TenListITileState extends State<TenListITile> {
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
    return InkWell(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return TenScheme.primary300Opacity; // 按下时的涟漪颜色
          }
          return null;
        },
      ),
      borderRadius: BorderRadius.circular(12),
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
