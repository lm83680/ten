import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ten/style/index.dart';

class TenSwitch extends StatelessWidget {
  const TenSwitch(
      {super.key,
      required this.value,
      required this.onChanged,
      this.hapticFeedback = true});
  final bool value;
  final void Function(bool) onChanged;

  ///震动反馈
  final bool hapticFeedback;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: 0.8,
        child: Switch(
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: TenScheme.neutralLight50,
          activeColor: Colors.white,
          activeTrackColor: TenScheme.primary,
          trackOutlineColor: WidgetStateColor.transparent,
          value: value,
          onChanged: (value) {
            onChanged(value);
            if (hapticFeedback) HapticFeedback.lightImpact();
          },
        ));
  }
}
