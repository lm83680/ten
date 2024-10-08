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
      appBar: TenAppBar(title: "交互反馈"),
      body: TenCard.column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TenListITile(title: "rawSnackbar 横幅提醒"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TenButton(
                      "primary",
                      onTap: () {
                        TenFeedBack.showTenSnackbar(context, "默认提醒",
                            message: "使用预设主题色");
                      },
                    ),
                    TenButton.success(
                      "success",
                      onTap: () {
                        TenFeedBack.showTenSnackbar(context, "Success",
                            message: "这是一个带点击事件的横幅，点击返回上一页",
                            type: FeedbackOptionType.success(),
                            onTap: () => Navigator.pop(context));
                      },
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TenButton.wraning(
                        "warning",
                        onTap: () {
                          TenFeedBack.showTenSnackbar(context, "Warning",
                              message: "使用预设主题色",
                              type: FeedbackOptionType.warning());
                        },
                      ),
                      TenButton.error(
                        "error",
                        onTap: () {
                          TenFeedBack.showTenSnackbar(context, "Error",
                              message: "使用预设主题色",
                              type: FeedbackOptionType.error());
                        },
                      )
                    ]),
                const TenListITile(
                  title: "showTenLoading() 全屏幕加载状态",
                  subtitle: "发起一个全屏幕的遮罩，一般用于网络请求时，必须手动使用hideTenLoading()关闭",
                ).padding(top: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TenButton(
                      "推荐用法",
                      onTap: () {
                        TenFeedBack.showTenLoading(context);
                        Future.delayed(const Duration(seconds: 3))
                            .then((_) => TenFeedBack.hideTenLoading());
                      },
                    ),
                    TenButton(
                      "强制带卡片",
                      onTap: () {
                        TenFeedBack.showTenLoading(context, showCard: true);
                        Future.delayed(const Duration(seconds: 3))
                            .then((_) => TenFeedBack.hideTenLoading());
                      },
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TenButton(
                        "message 自动带卡片",
                        onTap: () {
                          TenFeedBack.showTenLoading(context,
                              message: "message");
                          Future.delayed(const Duration(seconds: 3))
                              .then((_) => TenFeedBack.hideTenLoading());
                        },
                      )
                    ]),
                const TenListITile(
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
                ).intrinsicWidth().withLoading(isCardLoading, size: 14),
                TenButton(
                  "对话框",
                  onTap: () => {
                    TenFeedBack.showTenDialog(context,title: "提示",message: "确定退出吗")
                  },
                ).intrinsicWidth()
              ].withSeparator().withIntervals(hSize: 16))
          .scrollView(),
    );
  }
}
