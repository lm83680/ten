import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class ExampleButton extends StatelessWidget {
  const ExampleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TenAppBar(title: "通用按钮"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TenListITile(
            title: "一般使用方法",
            subtitle: "目前接受触发onTap和触发onLongPress",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TenButton(
                "primary",
                onTap: () {
                  showTenSnackbar(context, "触发按钮", message: "触发onTap");
                },
                onLongPress: () {
                  showTenSnackbar(context, "触发按钮", message: "触发onLongPress");
                },
              ),
              TenButtonText("primary text", onTap: () {}),
              TenButtonBorder(
                "primary",
                onTap: () {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TenButton(
                "lefticon",
                lefticon: Icon(Icons.ice_skating, color: Colors.white),
                onTap: () {},
              ),
              TenButton(
                "righticon",
                righticon: Icon(Icons.balance, color: Colors.white),
                onTap: () {},
              ),
            ],
          ),
          const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TenButton("失效"),
                TenButtonText("事件为null时颜色配置无效"),
              ]),
          const TenDivider(),
          const TenListITile(title: "预设按钮类型"),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            TenButton.success("成功", onTap: () {}),
            TenButtonText.success("成功", onTap: () {}),
            TenButtonBorder.success("成功", onTap: () {}),
            TenButton.success(
              "成功",
              righticon: const Icon(
                Icons.done,
                color: Colors.white,
                size: 16,
              ),
              onTap: () {},
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            TenButton.wraning("警告", onTap: () {}),
            TenButtonText.wraning("警告", onTap: () {}),
            TenButtonBorder.wraning("警告", onTap: () {}),
            TenButton.wraning(
              "警告",
              righticon: const Icon(
                Icons.error_outline_rounded,
                color: Colors.white,
                size: 16,
              ),
              onTap: () {},
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            TenButton.error("危险", onTap: () {}),
            TenButtonText.error("危险", onTap: () {}),
            TenButtonBorder.error("危险", onTap: () {}),
            TenButton.error(
              "危险",
              righticon: const Icon(
                Icons.do_disturb_alt_rounded,
                color: Colors.white,
                size: 16,
              ),
              onTap: () {},
            ),
          ]),
          const TenDivider(),
        ].withPadding(vertical: 16),
      ).paddingAll(16).scrollView(),
    );
  }
}
