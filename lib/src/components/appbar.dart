import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class TenAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String? title;
  final Widget? action;

  ///默认自动提供返回
  final bool? autoShowPop;

  final bool? centerTitle;

  final Color? backgroundColor;

  ///放入appbar底部的内容
  final PreferredSizeWidget? bottom;

  ///若为true,将渲染出SliverAppBar
  final bool? sliver;

  ///如果该值不为空，文字会代替返回按钮
  final String? backText;
  TenAppBar(
      {super.key,
      this.title,
      this.backText,
      this.action,
      this.autoShowPop = true,
      this.centerTitle = true,
      this.backgroundColor,
      this.sliver,
      this.bottom})
      : preferredSize = Size.fromHeight(bottom==null ? 60 : bottom.preferredSize.height + 60);

  TenAppBar.sliver(
      {super.key,
      this.title,
      this.backText,
      this.action,
      this.autoShowPop = true,
      this.centerTitle = true,
      this.backgroundColor,
      this.bottom})
      : preferredSize = Size.fromHeight(bottom==null ? 60 : bottom.preferredSize.height + 60),
        sliver = true;

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;
    final appBar = AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      surfaceTintColor: TenScheme.primary300,
      bottom: bottom,
      leading: autoShowPop == false
        ? null
        : backText != null
            ? TextButton(
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.pressed)) {
                        return TenScheme.primary300Opacity; // 按下时的涟漪颜色
                      }
                      return null;
                    },
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  backText!,
                  style: TenScheme.actionM.copyWith(color: TenScheme.primary),
                ))
            : canPop
                ? IconButton(
                    iconSize: 28,
                    highlightColor: Colors.transparent,
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.navigate_before_rounded))
                : null,
      actions: [action.show().padding(right: 24)],
      title: title == null
          ? null
          : Text(
              title!,
              style: TenScheme.h3,
            ),
    );

    return sliver == true
        ? SliverAppBar(
            automaticallyImplyLeading: appBar.automaticallyImplyLeading,
            elevation: appBar.elevation,
            floating: true, // 仅 `SliverAppBar` 有的特性
            snap: true,// 仅 `SliverAppBar` 有的特性
            centerTitle: appBar.centerTitle,
            backgroundColor: appBar.backgroundColor,
            surfaceTintColor: appBar.surfaceTintColor,
            bottom: appBar.bottom,
            leading: appBar.leading,
            actions: appBar.actions,
            title: appBar.title,
          )
        : appBar;
  }
}
