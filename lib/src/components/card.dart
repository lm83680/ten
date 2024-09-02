import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class TenCard extends StatelessWidget {
  const TenCard({required this.child, this.padding, this.margin, super.key});

  // 命名构造函数
  TenCard.column(
      {required List<Widget> children,
      crossAxisAlignment,
      this.padding,
      this.margin,
      super.key})
      : child = Column(
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: children,
        );

  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: margin ?? const EdgeInsets.all(16),
        child: Ink(
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16)),
          child: child,
        ));
  }
}

class TenCardPreset extends StatelessWidget {
  const TenCardPreset(
      {super.key,
      this.margin,
      required this.title,
      this.subtitle,
      required this.backgorund,
      this.aspectRatio = 3/2,
      this.bottom, this.description, this.tag});
  final String title;
  final String? subtitle;
  final Widget backgorund;
  final Widget? bottom;
  final EdgeInsets? margin;
  final double aspectRatio;
  final String? description;
  final Widget? tag;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: aspectRatio,
            child: Stack(
              children: [
                SizedBox.expand(child: backgorund),
                // 渐变遮罩层
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent], // 黑色到透明的渐变
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
               Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: DefaultTextStyle(
                  style:const TextStyle(color: Colors.white),
                  child: TenListITile(
                    title: title,
                    subtitle: subtitle,
                    maxLines: 1,
                  ),
                )),
                if(tag!=null) Positioned(
                  top: 16,
                  right: 16,
                  child: tag!)
              ],
            ),
          ),
          if(description!=null) Text(description!).padding(left: 16,right: 16,top: 16),
          if (bottom != null) bottom!.padding(left: 4, right: 16).paddingAll(16)
        ],
      ),
    );
  }
}
