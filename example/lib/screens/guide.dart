import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class ExampleGuide extends StatefulWidget {
  const ExampleGuide({super.key});

  @override
  State<ExampleGuide> createState() => _ExampleGuideState();
}

class _ExampleGuideState extends State<ExampleGuide> {
  final GlobalKey _key = GlobalKey();
  final GlobalKey _key2 = GlobalKey();
  final GlobalKey _key3 = GlobalKey();
  final GlobalKey _key4 = GlobalKey();
  final GlobalKey _key5 = GlobalKey();

  void _toggleTooltip() async {
    List<GlobalKey> list = [_key, _key2, _key3, _key4, _key5];
    for (var i = 0; i < list.length; i++) {
      var element = list[i];
      await TenToolTip.showToolTip(
          context,
          "showToolTip 是一个Future<void> 函数，意味着你可以使用await让程序等待ToolTip被销毁\n${i+1}/${list.length}",
          element,
          title: "Hello");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TenAppBar(key: _key4,title: "引导"),
        floatingActionButton: FloatingActionButton(
            key: _key5,
            onPressed: () => {},
            backgroundColor: TenScheme.primary,
            child: const Text(
              "底部",
              style: TextStyle(color: Colors.white),
            )),
        body: TenCard.column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TenButton(
              "开始",
              key: _key,
              onTap: () => _toggleTooltip(),
            ).intrinsicWidth(),
            TenListItem(
              title: "你可能发现了，引导实际上是链式调用Tooltip",
              subtitle: "将每个Tooltip的销毁回调都设为打开下一个tooltip即可",
              trailing: IconButton(
                key: _key2,
                icon: Icon(
                  Icons.ice_skating,
                  color: TenScheme.primary,
                ),
                onPressed: () => {},
              ),
            ),
            TenListItem(
              key: _key3,
              title: "tooltip自动定位目标所在的位置",
              subtitle: "所以气泡的箭头总是指向目标",
              leading: IconButton(
                icon: Icon(
                  Icons.headphones,
                  color: TenScheme.primary,
                ),
                onPressed: () => {},
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.navigate_next_rounded,
                  color: TenScheme.primary,
                ),
                onPressed: () => {},
              ),
            ),
          ],
        ));
  }
}
