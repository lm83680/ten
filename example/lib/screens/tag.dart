import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class ExampleTag extends StatelessWidget {
  const ExampleTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TenAppBar(title: "标签"),
      body: TenCard.column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TenSection(name: "一般标签"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TenTag("primary"),
              TenTag.success("success"),
              TenTag.wraning("wraning"),
              TenTag.error("error"),
            ],
          ),
          TenSection(name: "朴素"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const TenTag(
                "primary",
                plain: true,
              ),
              TenTag.success(
                "success",
                plain: true,
              ),
              TenTag.wraning(
                "wraning",
                plain: true,
              ),
              TenTag.error(
                "error",
                plain: true,
              ),
            ],
          ),
          const TenSection(name: "可触发点击和长按事件"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TenTag(
                "ontap",
                onTap: () {
                  showTenSnackbar(context, "ontap");
                },
                plain: true,
              ),
              TenTag(
                "success",
                onLongPress:() {
                  showTenSnackbar(context, "onLongPress");
                },
                plain: true,
              ),
            ],
          ),
          const TenSection(name: "自定义颜色"),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TenTag(
                "Orange And Plain",
                backgorundColor: Colors.orange,
                plain: true,
              ),
              TenTag(
                "orange",
                 backgorundColor: Colors.orange,
              ),
            ],
          )
        ].withSeparator(
            separator: const TenDivider(
          mtop: 8,
          mbottom: 16,
        )),
      ).scrollView(),
    );
  }
}
