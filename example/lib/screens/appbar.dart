import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class ExampleTenAppbar extends StatelessWidget {
  const ExampleTenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TenAppBar(title: "AppBar", action: Text("action")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TenDivider(mbottom: 60),
          TenAppBar(
              title: "一般用法",
              action: Icon(
                Icons.settings,
                color: Colors.blue,
              )),
          TenDivider(mbottom: 60),
          TenAppBar(title: "不提供返回按钮", autoShowPop: false),
          TenDivider(mbottom: 60),
          TenAppBar(
            title: "自定义返回文字",
            backText: "取消",
          ),
        ],
      ),
    );
  }
}
