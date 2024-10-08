import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ten/style/index.dart';

enum TenAvatarsShape { circle, square }

///头像组件
class TenAvatar extends StatelessWidget {
  const TenAvatar(
      {required this.size,
      this.shape = TenAvatarsShape.square,
      this.src,
      this.child,
      this.backgroundColor,
      super.key});

  final Color? backgroundColor;

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
        (shape == TenAvatarsShape.circle ? size / 2 : size / 8),
      ),
      child: Container(
        width: size,
        height: size,
        color: backgroundColor ?? TenScheme.primary300,
        child: src != null
            ? CachedNetworkImage(
                imageUrl: src!,
                imageBuilder: (context, imageProvider) => Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    width: size,
                    height: size,
                  ),
              )
            : child,
      ),
    );
  }
}
