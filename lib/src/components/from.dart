import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

///表单
class TenFrom extends StatefulWidget {
  const TenFrom(
      {super.key,
      required this.model,
      this.labelWidth = 88,
      this.rules,
      required this.children});

  ///表单的数据对象
  final Map<String, dynamic> model;

  ///标签的长度 default=48
  final double labelWidth;
  final List<RulesItem>? rules;

  ///表单项目
  final List<TenFromItem> children;

  @override
  State<TenFrom> createState() => _TenFromState();

  ///校验数据,返回未通过验证的RulesItem
  static List onValidate(List<RulesItem>? rules, Map<String, dynamic> data,
      {bool? autoTip, BuildContext? context}) {
    if (rules == null) return [];
    List<RulesItem> errorIndex = [];
    for (var rule in rules) {
      if (data.keys.contains(rule.name)) {
        //如果validation存在，且不通过校验返回false.
        if (rule.validation != null && !rule.validation!(data[rule.name])) {
          errorIndex.add(rule);
        }
        //如果validation不存在，且 isRequired 不为 false , 值为空则返回 false
        else if (rule.isRequired != false && valueIsEmpty(data[rule.name])) {
          errorIndex.add(rule);
        }
      }
    }
    if (errorIndex.isNotEmpty && autoTip == true) {
      if (context == null) throw "autoTip == true && context==null , error";
      showTenSnackbar(context, "校验失败",
          message: errorIndex.map((rule) {
            return rule.desction ?? '[${rule.name}]校验不通过';
          }).join('; '),
          type: FeedbackOptionType.error());
    }
    return errorIndex;
  }
}

class _TenFromState extends State<TenFrom> {
  bool shouldShowAsterisk(String key) {
    if (widget.rules == null) return false;
    for (var element in widget.rules!) {
      if (element.name == key) {
        if (element.isRequired == true ||
            (element.isRequired == null && element.validation == null)) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: widget.children
            .map((element) {
              Widget label = Text(element.label, style: TenScheme.action);
              if (element.help != null) {
                GlobalKey key = GlobalKey();
                label = GestureDetector(
                  onTap: () => TenToolTip.showToolTip(
                      context,
                      element.help!,
                      key,
                      title: element.label),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    key: key,
                    children: [
                      Icon(Icons.help_outline_rounded,
                          size: 14, color: TenScheme.primary),
                      Text(element.label, style: TenScheme.action),
                    ],
                  ),
                );
              }
              return Row(
                children: [
                  SizedBox(
                          width: widget.labelWidth,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: element.modelKey != null &&
                                      shouldShowAsterisk(element.modelKey!)
                                  ? Badge(
                                      alignment: Alignment.topLeft,
                                      backgroundColor: Colors.transparent,
                                      offset: const Offset(-14, 0),
                                      label: Text("*",
                                          style: TextStyle(
                                              color: TenScheme.error,
                                              fontSize: 14)),
                                      child: label,
                                    )
                                  : label))
                      .padding(right: 24),
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerRight,
                    child: element.inputInput,
                  ))
                ],
              );
            })
            .toList()
            .withIntervals(hSize: 16));
  }
}

class TenFromItem {
  const TenFromItem(
      {required this.label,
      this.modelKey,
      this.help,
      required this.inputInput});

  final String label;

  ///点击label，以气泡的形式弹出此提示
  final String? help;

  ///将根据此值计算验证规则
  final String? modelKey;
  final Widget inputInput;
}

/// 若validation为空，不为空即可通过校验,若不为空，将依据validation的规则
class RulesItem {
  final String name;

  ///是否不能为null，展示星号的依据
  final bool? isRequired;
  final bool Function(dynamic)? validation;

  ///校验不通过的提示词
  final String? desction;
  RulesItem(
      {required this.name, this.isRequired, this.desction, this.validation});
}
