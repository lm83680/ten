import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class ExampleExtension extends StatelessWidget {
  const ExampleExtension({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TenAppBar(title: "拓展"),
      body: TenCard.column(
        children: const [
          TenListItem(
            title: "边距",
            subtitle: "[.padding.paddingAll]为部件添加内边距",
          ),
          TenListItem(
            title: "Widget?",
            subtitle: "[.show]添加部件空安全，若为空，渲染sizebox",
          ),
          TenListItem(
            title: "分割线",
            subtitle: "[.withSeparator]在部件列表中插入分割线",
          ),
        ].withSeparator(),
      ),
    );
  }
}
