import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class ExampleFeedBack extends StatefulWidget {
  const ExampleFeedBack({super.key});

  @override
  State<ExampleFeedBack> createState() => _ExampleFeedBackState();
}

class _ExampleFeedBackState extends State<ExampleFeedBack> {
  bool isLoading = false;
  bool isCardLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TenAppBar(title: "交互反馈"),
      body: TenCard.column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TenListItem(title: "rawSnackbar 横幅提醒"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TenButton(
                  "primary",
                  onTap: () {
                    showTenSnackbar(context, "默认提醒", message: "使用预设主题色");
                  },
                ),
                TenButton.success(
                  "success",
                  onTap: () {
                    showTenSnackbar(context, "Success",
                        message: "这是一个带点击事件的横幅，点击返回上一页",
                        type: FeedbackOptionType.success(),
                        onTap: () => Navigator.pop(context));
                  },
                ),
                TenButton.wraning(
                  "warning",
                  onTap: () {
                    showTenSnackbar(context, "Warning",
                        message: "使用预设主题色", type: FeedbackOptionType.warning());
                  },
                ),
                TenButton.error(
                  "error",
                  onTap: () {
                    showTenSnackbar(context, "Error",
                        message: "使用预设主题色", type: FeedbackOptionType.error());
                  },
                )
              ],
            ).intrinsicHeight(),
            const TenListItem(
              title: "showTenLoading() 全屏幕加载状态",
              subtitle: "发起一个全屏幕的遮罩，一般用于网络请求时，必须手动使用hideTenLoading()关闭",
            ).padding(top: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TenButton(
                  "推荐用法",
                  onTap: () {
                    showTenLoading(context);
                    Future.delayed(const Duration(seconds: 3))
                        .then((_) => hideTenLoading());
                  },
                ),
                TenButton(
                  "强制带卡片",
                  onTap: () {
                    showTenLoading(context, showCard: true);
                    Future.delayed(const Duration(seconds: 3))
                        .then((_) => hideTenLoading());
                  },
                ),
                TenButton(
                  "message 自动带卡片",
                  onTap: () {
                    showTenLoading(context, message: "message");
                    Future.delayed(const Duration(seconds: 3))
                        .then((_) => hideTenLoading());
                  },
                )
              ],
            ),
            const TenListItem(
              title: ".withLoading(bool) 让一个部件进入loading状态",
              subtitle: "直接对Widget使用 .withLoading(bool)",
            ).padding(top: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const TenAvatar(
                  size: 120,
                  src: "http://q1.qlogo.cn/g?b=qq&nk=1010365&s=100",
                ).withLoading(isLoading).withClipRRect(16),
                TenButton(
                  isLoading ? "关闭" : "开启",
                  onTap: () => setState(() => isLoading = !isLoading),
                ),
              ],
            ),
            TenButton.error(
              "对自身使用",
              lefticon: const Icon(
                Icons.warning_rounded,
                color: Colors.white,
              ),
              onTap: () => setState(() => isCardLoading = !isCardLoading),
            ).intrinsicWidth().withLoading(isCardLoading,size: 14),
          ].withSeparator().withIntervals(hSize: 16)),
    );
  }
}
