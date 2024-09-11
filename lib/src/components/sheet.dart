import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

interface class TenButtonSheet {
  ///初始弹出窗口 使用 await show 接收 Navigator.of(context).pop(T) 的内容，建议声明 T 的类型
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    bool? float,
    bool? isScrollControlled,
  }) async {
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // 确保背景透明
      isScrollControlled: isScrollControlled ?? false,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets, // 考虑键盘高度
          child: Container(
            width: double.infinity,
            margin: float == true
                ? const EdgeInsets.all(16.0)
                : null, // 可自定义 margin
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: float == true
                    ? BorderRadius.circular(16)
                    : const BorderRadius.only(
                        topRight: Radius.circular(16),
                        topLeft: Radius.circular(16))),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 120,
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }

  ///预设 弹出一个IOS选择器风格的选择器，更易用
  static Future<void> selector(BuildContext context,
      {required List<TenFromSelectorModel> options,
      required void Function(TenFromSelectorModel) onSummit,
      String title = "请选择",
      String? desction,
      dynamic defaultOptionKey}) async {
    int selectedItem = 0;
    if (defaultOptionKey != null) {
      selectedItem = options.indexWhere((item) => item.key == defaultOptionKey);
    }
    TenFromSelectorModel? result =
        await show<TenFromSelectorModel>(context,
            child: Column(
              children: [
                TenListITile(
                    title: title,
                    subtitle: desction,
                    trailing: TenButton(
                      "确认",
                      onTap: () =>
                          Navigator.pop(context, options[selectedItem]),
                    )),
                Expanded(
                    child: CupertinoPicker(
                  magnification: 1.22,
                  useMagnifier: true,
                  itemExtent: 40,
                  scrollController:
                      FixedExtentScrollController(initialItem: selectedItem),
                  onSelectedItemChanged: (int index) => selectedItem = index,
                  children: List<Widget>.generate(options.length, (int index) {
                    return Center(
                        child: Text(
                      options[index].value,
                      style: TenScheme.h3,
                    ));
                  }),
                ))
              ],
            ));
    if (result != null) onSummit(result);
  }

  ///预设 弹出一个IOS选择器风格的选择器，允许左侧自定义widget
  static Future<void> selectorPlus(BuildContext context,
      {required List<TenFromSelectorModel> options,
      required void Function(TenFromSelectorModel) onSummit,
      String? desction,
      required Widget title,
      dynamic defaultOptionKey}) async {
    int selectedItem = 0;
    if (defaultOptionKey != null) {
      selectedItem = options.indexWhere((item) => item.key == defaultOptionKey);
    }
    TenFromSelectorModel? result =
        await show<TenFromSelectorModel>(context,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: title),
                    TenButton(
                      "确认",
                      onTap: () => Navigator.pop(context, options[selectedItem]),
                    )
                  ],
                ),
                Expanded(
                    child: CupertinoPicker(
                  magnification: 1.22,
                  useMagnifier: true,
                  itemExtent: 40,
                  scrollController:
                      FixedExtentScrollController(initialItem: selectedItem),
                  onSelectedItemChanged: (int index) => selectedItem = index,
                  children: List<Widget>.generate(options.length, (int index) {
                    return Center(
                        child: Text(
                      options[index].value,
                      style: TenScheme.h3,
                    ));
                  }),
                ))
              ],
            ));
    if (result != null) onSummit(result);
  }
}


class TenFromSelectorModel {
  final dynamic key;
  final String value;
  TenFromSelectorModel(this.value, {required this.key});
}