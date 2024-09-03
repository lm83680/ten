import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

///表单
class TenFrom extends StatefulWidget {
  const TenFrom(
      {super.key,
      required this.model,
      this.labelWidth = 80,
      this.rules,
      required this.children});

  ///表单的数据对象
  final Map<String, dynamic> model;

  ///标签的长度 default=80 刚好 5个字 或 4个字加上角标
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
      if (data.keys.contains(rule.key)) {
        //如果validation存在，且不通过校验返回false.
        if (rule.validation != null && !rule.validation!(data[rule.key])) {
          errorIndex.add(rule);
        }
        //如果validation不存在，且 isRequired 不为 false , 值为空则返回 false
        else if (rule.isRequired != false && valueIsEmpty(data[rule.key])) {
          errorIndex.add(rule);
        }
      }
    }
    if (errorIndex.isNotEmpty && autoTip == true) {
      if (context == null) throw ArgumentError("autoTip == true && context==null , error");
      TenFeedBack.showTenSnackbar(context, "校验失败",
          message: errorIndex.map((rule) {
            return rule.desction ?? '[${rule.key}]校验不通过';
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
      if (element.key == key) {
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
                      context, element.help!, key,
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
              Widget title = SizedBox(
                      width: widget.labelWidth,
                      child: Align(
                          alignment: element.tbStructure
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: element.ruleKey != null &&
                                  shouldShowAsterisk(element.ruleKey!)
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
                  .padding(right: 24);
              return element.tbStructure
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [title.padding(bottom: 8), element.inputWidget],
                    )
                  : Row(
                      children: [
                        title.padding(right: 24),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: element.inputWidget,
                          ),
                        )
                      ],
                    );
            })
            .toList()
            .withSeparator());
  }
}

class TenFromItem {
  const TenFromItem(
      {required this.label,
      this.ruleKey,
      this.help,
      required this.inputWidget,
      this.tbStructure = false});

  final String label;

  ///点击label，以气泡的形式弹出此提示
  final String? help;

  ///将根据此值计算验证规则
  final String? ruleKey;
  final Widget inputWidget;

  ///上下结构，一般仅有多行输入框才会使用,注意，如果使用该参数，建议将另外起一行表单
  final bool tbStructure;
}

/// 若validation为空，不为空即可通过校验,若不为空，将依据validation的规则
class RulesItem {
  final String key;

  ///是否不能为null，展示星号的依据
  final bool? isRequired;
  final bool Function(dynamic)? validation;

  ///校验不通过的提示词
  final String? desction;
  RulesItem(
      {required this.key, this.isRequired, this.desction, this.validation});
}

///仅为文本，依靠点击事件触发，一般如时间选择器，依靠函数触发的数据选项等
class TenFromDefaultLabel extends StatelessWidget {
  const TenFromDefaultLabel(this.text,
      {required this.onTap, this.color, super.key});
  final void Function() onTap;
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          color: Colors.transparent,
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                text,
                style: TenScheme.action
                    .copyWith(color: color ?? TenScheme.primary, height: 1),
              ).padding(right: 8),
              Icon(Icons.navigate_next_rounded,
                  color: color ?? TenScheme.primary, size: 20)
            ],
          )),
    );
  }
}
