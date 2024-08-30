import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ten/ten.dart';

class TrianglePainter extends CustomPainter {
  final Color color;
  final bool isInverted;

  TrianglePainter({
    required this.color,
    this.isInverted = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path();
    if (isInverted) {
      // 绘制倒三角形
      path.moveTo(0, 0); // 左上角
      path.lineTo(size.width, 0); // 右上角
      path.lineTo(size.width / 2, size.height); // 底部中间
    } else {
      // 绘制正三角形
      path.moveTo(size.width / 2, 0); // 顶点
      path.lineTo(0, size.height); // 左下角
      path.lineTo(size.width, size.height); // 右下角
    }
    path.close(); // 闭合路径

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.isInverted != isInverted;
  }
}

///绘制三角形
class TriangleWidget extends StatelessWidget {
  final Color color;
  final double width;
  final double height;
  final bool isInverted;
  const TriangleWidget(
      {required this.color,
      this.width = 12,
      this.height = 8,
      this.isInverted = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: TrianglePainter(isInverted: isInverted, color: color),
    );
  }
}

class TenPopupRoute extends PopupRoute {
  final Duration _duration = const Duration(milliseconds: 200);
  Widget child;

  TenPopupRoute({required this.child});

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

class TenToolTip extends StatefulWidget {
  const TenToolTip(
      {required this.popKey,
      super.key,
      this.title,
      required this.message,
      this.onTap});
  final GlobalKey popKey;
  final String? title;
  final String message;
  final GestureTapCallback? onTap;
  static Future<void> showToolTip(context, String message, GlobalKey popKey,
      {String? title,
      GestureTapCallback? onTap,
      Offset? offset}) async {
    assert(popKey.currentContext != null &&
        popKey.currentContext!.findRenderObject() != null);
    if (popKey.currentContext == null ||
        popKey.currentContext!.findRenderObject() == null) return;
    await Navigator.push(
        context,
        TenPopupRoute(
            child: TenToolTip(
          title: title,
          message: message,
          onTap: onTap,
          popKey: popKey,
        )));
  }

  @override
  State<TenToolTip> createState() => _TenToolTipState();
}

class _TenToolTipState extends State<TenToolTip> {
  /// targetView的位置
  Rect _showRect = Rect.zero;
  Size _screenSize = Size.zero;
  final GlobalKey _key = GlobalKey();
  double childHeight = 0.0;
  bool isUp = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {
          _showRect = _getWidgetGlobalRect(widget.popKey);
          _screenSize = PlatformDispatcher.instance.views.first.physicalSize /
              PlatformDispatcher.instance.views.first.devicePixelRatio;

          //如果目标位置在全屏幕高度的2/3之下，气泡在上方弹出
          isUp = _showRect.top > (_screenSize.height * 2 / 3);
          if (isUp) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final RenderBox? renderBox =
                  _key.currentContext?.findRenderObject() as RenderBox?;
              setState(() {
                if (renderBox != null) {
                  childHeight = renderBox.size.height;
                } else {
                  isUp = false;
                }
              });
            });
          }
        });
      },
    );
  }

  // 获取targetView的位置
  Rect _getWidgetGlobalRect(GlobalKey key) {
    try {
      BuildContext? ctx = key.currentContext;
      RenderObject? renderObject = ctx?.findRenderObject();
      RenderBox renderBox = renderObject as RenderBox;
      var offset = renderBox.localToGlobal(Offset.zero);
      return Rect.fromLTWH(
          offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
    } catch (e) {
      debugPrint('获取尺寸信息异常');
      return Rect.zero;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showRect == Rect.zero || _screenSize == Size.zero) {
      return const SizedBox();
    }

    ///三角形的位置在目标的中心
    Rect tipTriangleRect = Rect.fromLTWH(
        // 原始的左边位置不变
        _showRect.left,
        //距离 2 ，在减去三角形本身高度 8
        isUp ? (_showRect.top - 2 - 8) : (_showRect.top + _showRect.height + 2),
        _showRect.width,
        8 // 高度使用三角形配置参数
        );

    /// 修改位置并调整宽度
    Rect tipshowRect = Rect.fromLTWH(
        24, // 距离屏幕有安全区域
        isUp
            ? (_showRect.top - childHeight - 10)
            : (_showRect.top + _showRect.height + 10), // 向下移动三角形的高度
        _screenSize.width - 48,
        _screenSize.height // 全屏幕高度
        );

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onPanUpdate: (details) => Navigator.pop(context),
              onTap: () => Navigator.pop(context),
              child: Container(
                color: Colors.transparent, // 确保透明
              ),
            ),
          ),
          Positioned.fromRect(
              rect: tipTriangleRect,
              child: Center(
                  child: TriangleWidget(
                      isInverted: isUp, color: TenScheme.neutralDark))),
          Positioned.fromRect(
              rect: tipshowRect,
              child: GestureDetector(
                  onTap: widget.onTap ?? () => Navigator.pop(context),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          key: _key,
                          decoration: BoxDecoration(
                            color: TenScheme.neutralDark,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (widget.title != null)
                                  Text(
                                    widget.title!,
                                    style: TenScheme.h3
                                        .copyWith(color: Colors.white),
                                  ).padding(bottom: 8),
                                Text(
                                  widget.message,
                                  style: TenScheme.desction
                                      .copyWith(color: Colors.white),
                                )
                              ],
                            ),
                          ))
                    ],
                  )))
        ],
      ).animate().fadeIn(),
    );
  }
}
