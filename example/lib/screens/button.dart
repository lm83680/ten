import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class ExampleButton extends StatelessWidget {
  const ExampleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TenAppBar(title: "通用按钮"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TenSection(name: "一般"),
          Row(
            children: [
              TenButton(
                "primary",
                onTap: () {print("222");},
              ),
              TenButtonText("primary text", onTap: () {
                
              }),
              TenButtonBorder(
                "primary",
                onTap: () {},
              ),
            ].withPadding(),
          ),
          Row(
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
            ].withPadding(),
          ),
          Row(
              children: [
            const TenButton("失效"),
            const TenButtonText("事件为null时颜色配置无效"),
          ].withPadding()),
          const TenDivider(),
          const TenSection(name: "类型"),
          Row(
              children: [
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
          ].withPadding()),
          Row(
              children: [
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
          ].withPadding()),
          Row(
              children: [
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
          ].withPadding()),
          const TenDivider(),
        ].withPadding(vertical: 16),
      ).paddingAll(16).scrollView(),
    );
  }
}
