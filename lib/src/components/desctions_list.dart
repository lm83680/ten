import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ten/ten.dart';

class TenDesctionsItemModel {
  final String label;
  final String desction;
  final bool? canCopy;
  TenDesctionsItemModel(this.label, this.desction, {this.canCopy});
}

class TenDesctionsList extends StatefulWidget {
  const TenDesctionsList(
      {super.key,
      this.interval = 16,
      this.labelWidth = 80,
      this.defalutShowItems = 8,
      required this.list,
      this.canCopy = false});

  //默认展示的最大项数
  final int defalutShowItems;

  ///每项的间隔
  final double interval;
  final List<TenDesctionsItemModel> list;
  final double labelWidth;

  ///是否可复制，ItemModel优先级跟高
  final bool? canCopy;
  @override
  State<TenDesctionsList> createState() => _TenDesctionsListState();
}

class _TenDesctionsListState extends State<TenDesctionsList> {
  bool isShowMore = false;

  void showMore() {
    setState(() {
      isShowMore = true;
    });
  }

  void copyer(String str) {
    Clipboard.setData(ClipboardData(text: str));
    TenFeedBack.showTenSnackbar(context, "联系方式已复制");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List<Widget>.generate(
            isShowMore
                ? widget.list.length
                : min(widget.list.length, widget.defalutShowItems),
            (int index) {
          TenDesctionsItemModel item = widget.list[index];
          return Row(
            children: [
              SizedBox(
                width: widget.labelWidth,
                child: Text(item.label,
                    style: TenScheme.desction
                        .copyWith(fontWeight: FontWeight.w600)),
              ),
              Expanded(
                  child: GestureDetector(
                onTap: item.canCopy == true ||
                        (widget.canCopy == true && item.canCopy != false)
                    ? () => copyer(item.desction)
                    : null,
                child: Text(item.desction,
                    textAlign: TextAlign.right, style: TenScheme.desction),
              ))
            ],
          );
        }).animate(interval: const Duration(milliseconds: 40)).fadeIn(),
        if (!isShowMore && widget.list.length > widget.defalutShowItems)
          GestureDetector(
            onTap: showMore,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("查看更多", style: TenScheme.desction),
                Icon(
                  Icons.expand_more_rounded,
                  color: TenScheme.neutralDark200,
                )
              ],
            ),
          )
      ].withIntervals(hSize: widget.interval),
    );
  }
}
