import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

///绝大部分的App一般不使用此种方式（不符合用户体验优先原则）
///
///推荐你使用[TenButtonSheet.selector]
class TenDropdownMenuItem {
  final String value;
  final bool enabled;
  final String label;
  final Widget? icon;

  TenDropdownMenuItem(
      {required this.value,
      this.enabled = true,
      required this.label,
      this.icon});
}

class TenDropdownButton extends StatelessWidget {
  const TenDropdownButton(
      {super.key, required this.value, required this.items, this.onChanged});
  final String value;
  final List<TenDropdownMenuItem> items;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        elevation: 1,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(16),
        style: TenScheme.action.copyWith(color: TenScheme.textLight),
        value: value,
        onChanged: onChanged,
        items: items.map((e) {
          Color? color = e.enabled ? null : TenScheme.neutralLight;
          return DropdownMenuItem(
            enabled: e.enabled,
            value: e.value,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (e.icon != null)
                  IconTheme(
                          data: IconThemeData(size: 18, color: color),
                          child: e.icon!)
                      .padding(right: 8),
                Text(e.label, style: TextStyle(color: color))
              ],
            ).padding(right: 16),
          );
        }).toList(),
      ),
    ).intrinsicWidth();
  }
}
