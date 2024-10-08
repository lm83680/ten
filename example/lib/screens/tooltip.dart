import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class ExampleTooltip extends StatefulWidget {
  const ExampleTooltip({super.key});

  @override
  State<ExampleTooltip> createState() => _ExampleTooltipState();
}

class _ExampleTooltipState extends State<ExampleTooltip> {
  final GlobalKey _key = GlobalKey();
  final GlobalKey _key2 = GlobalKey();
  final GlobalKey _key3 = GlobalKey();
  final GlobalKey _key4 = GlobalKey();
  void _toggleTooltip(GlobalKey key) {
    TenToolTip.showToolTip(context, key,
        message: "这是常见使用方法，点击气泡外任意点关闭气泡，点击气泡也能触发对应回调这是常见使用方法，点击气泡外任意点关闭气泡，点击气泡也能触发对应回调",
        title: "一般方法", onTap: () {
      TenFeedBack.showTenSnackbar(context, "点击了气泡");
    });
  }

  void _toggleTooltipChild() {
    TenDropDown.showMenu(context, _key4,menus: [TenMenuModel("label", onTap: (){}),TenMenuModel("label222", onTap: (){}),TenMenuModel("label333", onTap: (){})]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TenAppBar(title: "气泡"),
        floatingActionButton: FloatingActionButton(
            key: _key4,
            onPressed: () => _toggleTooltip(_key4),
            backgroundColor: TenScheme.primary,
            child: const Text(
              "尝试我",
              style: TextStyle(color: Colors.white),
            )),
        body: TenCard.column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TenButton(
              "打开气泡",
              key: _key,
              onTap: () => _toggleTooltip(_key),
            ).intrinsicWidth(),
            Align(
              alignment: Alignment.center,
              child: TenButton(
                "打开气泡",
                key: _key2,
                onTap: () => _toggleTooltip(_key2),
              ).intrinsicWidth(),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TenButton(
                "打开气泡",
                key: _key3,
                onTap: () => _toggleTooltip(_key3),
              ).intrinsicWidth(),
            ),
             TenButton(
                "自定义气泡内容",
                onTap: () => _toggleTooltipChild(),
              ).intrinsicWidth(),
            TenButton(
              "让其他部件打开",
              onTap: () => _toggleTooltip(_key4),
            ).intrinsicWidth(),
          ],
        ));
  }
}
