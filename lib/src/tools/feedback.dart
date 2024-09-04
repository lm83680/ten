import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ten/ten.dart';

class FeedbackOptionType {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  // 默认构造函数
  FeedbackOptionType({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  //  Success 配置
  FeedbackOptionType.primary()
      : icon = Icons.info_rounded,
        iconColor = TenScheme.primary,
        backgroundColor = TenScheme.primary300;

  //  Success 配置
  FeedbackOptionType.success()
      : icon = Icons.check_circle_rounded,
        iconColor = TenScheme.success,
        backgroundColor = TenScheme.successBackGroud;

  // Warning 配置
  FeedbackOptionType.warning()
      : icon = Icons.warning_rounded,
        iconColor = TenScheme.wraning,
        backgroundColor = TenScheme.wraningBackGroud;

  // Error 配置
  FeedbackOptionType.error()
      : icon = Icons.error_rounded,
        iconColor = TenScheme.error,
        backgroundColor = TenScheme.errorBackGroud;
}

interface class TenFeedBack {
  static void showTenSnackbar(BuildContext context, String title,
      {String? message,
      Duration? duration,
      bool? canClose,
      GestureTapCallback? onTap,
      FeedbackOptionType? type}) {
    OverlayState? overlayState = Overlay.of(context);
    bool isClosed = false; // 用于追踪是否被手动关闭
    late OverlayEntry overlayEntry;
    Duration appduration = duration ?? const Duration(seconds: 3);
    FeedbackOptionType appType = type ?? FeedbackOptionType.primary();
    overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
            top: 24.0,
            left: 20.0,
            right: 20.0,
            child: SafeArea(
                child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: appType.backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(appType.icon, color: appType.iconColor),
                      const SizedBox(width: 16.0),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TenScheme.h4,
                          ),
                          if (message != null)
                            Text(
                              message,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ).padding(top: 4)
                        ],
                      )),
                      if (!(canClose == false))
                        IconButton(
                            onPressed: () {
                              overlayEntry.remove();
                              isClosed = true;
                            },
                            icon: const Icon(Icons.close_rounded))
                    ],
                  ),
                )
                    .animate()
                    .moveY(curve: Curves.decelerate, begin: -120, end: 0)
                    .fadeOut(
                        delay:
                            (appduration - const Duration(milliseconds: 600))),
              ),
            ))));

    overlayState.insert(overlayEntry);

    Future.delayed(appduration).then((_) {
      if (!isClosed) {
        overlayEntry.remove();
      }
    });
  }

  static OverlayEntry? _loadingEntry;

  static void showTenLoading(BuildContext context,
      {String? message, bool showCard = false}) {
    if (_loadingEntry != null) debugPrint("请不要让用户或程序重复调用showLoading");
    OverlayState? overlayState = Overlay.of(context);

    _loadingEntry = OverlayEntry(
      builder: (context) => Material(
        color: Colors.transparent,
        child: Container(
          color: TenScheme.neutralDark.withOpacity(0.48),
          child: Center(
            child: (message == null) && (!showCard)
                ? const CircularProgressIndicator(color: Colors.white)
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: (message == null)
                            ? const EdgeInsets.all(16)
                            : const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 36),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(
                                  color: TenScheme.primary),
                              if ((message != null)) Text(message)
                            ].withIntervals(hSize: 24)),
                      ),
                    )),
          ),
        ),
      ).animate().fadeIn(curve: Curves.decelerate),
    );

    if (_loadingEntry != null) overlayState.insert(_loadingEntry!);
  }

  static void hideTenLoading() {
    if (_loadingEntry != null) {
      _loadingEntry!.remove();
      _loadingEntry = null;
    }
  }

  static Future<void> showTenDialog(BuildContext context,
      {String? title,
      required String message,
      String? cancelText,
      String? confirmText = "确定"}) async {
    await await Navigator.push(
        context,
        TenPopupRoute(
            child: Material(
                color: Colors.transparent,
                child: Stack(children: [
                  Positioned.fill(
                    child: Container(
                        color: TenScheme.neutralDark.withOpacity(0.22), // 确保透明
                      )
                  ),
                  Center(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  if (title != null)
                                    Text(title, style: TenScheme.action).padding(bottom: 8, left: 16, right: 16),
                                  Text(message).padding(left: 16, right: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TenButtonText(cancelText ?? "取消",
                                          onTap: () =>
                                              Navigator.pop(context, false),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 12)),
                                      TenButtonBorder(
                                        confirmText ?? "确定",
                                        onTap: () =>
                                            Navigator.pop(context, true),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 12),
                                      )
                                    ].withPadding(horizontal: 8,vertical: 8),
                                  )
                                ],
                              )))),
                ]))));
  }
}

class TenDialogRoute extends PopupRoute {
  final Duration _duration = const Duration(milliseconds: 200);
  Widget child;

  TenDialogRoute({required this.child});

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
  @override
  Duration get reverseTransitionDuration => Duration.zero;
}
