import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class ExampleTenDivider extends StatelessWidget {
  const ExampleTenDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TenAppBar(title: "TenDivider 分割线"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TenCard.column(children: const [
            TenListITile(title: "mtop 和 mbotton 控制上下距离"),
            TenDivider(
              mtop: 24,
              mbottom: 60,
            ),
            TenListITile(title: "indent 控制左右边距"),
            TenDivider(
              indent: 24,
            ),
            TenListITile(title: "thickness 自定义厚度"),
            TenDivider(
              thickness: 6,
            ),
          ]),
          TenCard.column(
            children: [
              TenListITile(
                  maxLines: 5,
                  title: "vertical 为真时 竖向渲染",
                  onTap: () {
                    
                  },
                  subtitle:
                      "Row 通常不会自动限高，所以你需要在Row外层使用IntrinsicHeight 包裹限高，Ten 已经为你拓展了这个函数，对Row使用.intrinsicHeight()即可"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text("西嘎"),
                  Text("南噶"),
                  Text("哈密噶"),
                ].withSeparator(separator:TenDivider(
                  vertical: true,
                )),
              ).intrinsicHeight(),
            ],
          ),
          TenCard.column(
            children: [
              TenListITile(title: "自定义颜色"),
              TenDivider(
                color: TenScheme.error,
                indent: 24,
              )
            ],
          ),
        ],
      ),
    );
  }
}
