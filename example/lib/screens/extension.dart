import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class ExampleExtension extends StatelessWidget {
  const ExampleExtension({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TenAppBar(title: "拓展"),
      body: TenCard.column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          TenSection(name: "on Widget"),
          TenListItem(
            title: "滑动",
            subtitle: "[.scrollView]让一个部件变为可滑动",
          ),
          TenListItem(
            title: "边距",
            subtitle: "[.padding.paddingAll]为部件添加内边距",
          ),
          TenListItem(
            title: "尺寸限制",
            subtitle: "[.intrinsicHeight.intrinsicWidth]为Row、Cloumn等部件包裹尺寸限制",
          ),
          TenSection(name: "on Widget?"),
          TenListItem(
            title: "Widget?",
            subtitle: "[.show]添加部件空安全，若为空，渲染sizebox",
          ),
          TenSection(name: "on List<Widget>"),
          TenListItem(
            title: "间隔",
            subtitle: "[.withSeparator.withSeparator]在部件列表中插入分割线\n[.withIntervals]在个元素间插入size box\n[.withPadding]为每个部件都使用Padding",
          ),
        ].withSeparator(separator:TenDivider(mtop: 8,mbottom: 16,)),
      ).scrollView(),
    );
  }
}
