import 'package:flutter/material.dart';

enum TenAvatarsShape { circle, square }

class TenAvatar extends StatelessWidget {
  const TenAvatar(
      {required this.size,
      this.shape = TenAvatarsShape.square,
      this.src,
      this.child,
      super.key});

  ///Avatar 大小
  final double size;

  ///Avatar 形状
  ///
  ///[TenAvatarsShape.circle] 圆形
  ///
  ///[TenAvatarsShape.square] 圆角方型
  final TenAvatarsShape shape;

  ///Avatar 图片的源地址
  final String? src;

  ///你可以选择使用child完成内部的填充，一般见于Svg和本地资源的渲染
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        shape == TenAvatarsShape.circle ? size / 2 :  size / 8 ,
      ),
      child: Container(
        width: size,
        height: size,
        color: Colors.grey[200],
        child: src != null
            ? Image.network(
                src!,
                width: size,
                height: size,
                fit: BoxFit.cover,
              )
            : child,
      ),
    );
  }
}
