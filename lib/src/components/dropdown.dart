import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class TenMenuModel {
  final String label;
  final void Function() onTap;
  TenMenuModel(this.label, {required this.onTap});
}

///借助气泡组件实现的弹出菜单
class TenDropDown {
  static Future<void> showMenu(BuildContext context, GlobalKey key,
      {double menuWidth = 120, required List<TenMenuModel> menus}) async {
    await TenToolTip.showToolTip(
      context,
      key,
      childWidth: menuWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(menus.length, (int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context);
              menus[index].onTap();
            },
            child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                width: double.infinity,
                alignment: Alignment.center,
                child:  Text(menus[index].label)),
          );
        }).withSeparator(
            separator: TenDivider(
          color: TenScheme.neutralDark200,
        )),
      ),
    );
  }
}
