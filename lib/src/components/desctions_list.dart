import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class TenDesctionsItemModel {
  final String label;
  final String desction;
  TenDesctionsItemModel(this.label, this.desction);
}

class TenDesctionsList extends StatefulWidget {
  const TenDesctionsList(
      {super.key,
      this.interval = 16,
      this.labelWidth = 80,
      this.defalutShowItems = 8,
      required this.list});

  //默认展示的最大项数
  final int defalutShowItems;

  ///每项的间隔
  final double interval;
  final List<TenDesctionsItemModel> list;
  final double labelWidth;
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
                  child: Text(item.desction,
                      textAlign: TextAlign.right, style: TenScheme.desction))
            ],
          );
        }),
        if (!isShowMore && widget.list.length > widget.defalutShowItems)
          Center(
              child: TenButtonText(
            "查看更多",
            onTap: showMore,
            righticon: Icon(Icons.expand_more_rounded),
            textColor: TenScheme.neutralDark200,
          ))
      ].withIntervals(hSize: widget.interval),
    );
  }
}
