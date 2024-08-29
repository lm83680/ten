import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class TenAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String? title;
  final Widget? action;
  ///默认自动提供返回
  final bool? autoShowPop;

  ///如果该值不为空，文字会代替返回按钮
  final String? backText;
  const TenAppBar({super.key, this.title, this.backText, this.action,this.autoShowPop = true})
      : preferredSize = const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;

    return AppBar(
      automaticallyImplyLeading: false,
      leading: autoShowPop == false ? null : backText != null
          ? TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                backText!,
                style: TextStyle(color: TenScheme.primary),
              ))
          : canPop
              ? BackButton(
                  style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.pressed)) {
                        return TenScheme.primary300; // 按下时的涟漪颜色
                      }
                      return null;
                    },
                  ),
                  iconColor: WidgetStatePropertyAll(TenScheme.primary),
                  iconSize: const WidgetStatePropertyAll(20),
                ))
              : null,
      actions: [action.show().padding(right: 24)],
      title: title == null
          ? null
          : Text(
              title!,
              style: TenScheme.h2,
            ),
    );
  }
}
