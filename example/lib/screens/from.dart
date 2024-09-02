import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:example/components/brard_date_picker.dart';
import 'package:example/components/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class ExampleFrom extends StatefulWidget {
  const ExampleFrom({super.key});

  @override
  State<ExampleFrom> createState() => _ExampleFromState();
}

class _ExampleFromState extends State<ExampleFrom> {
  Map<String, dynamic> model = {
    "name": "",
    "phone": "",
    "number": 10,
    "isVip": 1,
    "dropdown": "月亮会",
    "dateRange": "",
    "dateSingle": "",
    "timeSingle": "",
    "radio": 0,
  };
  List<RulesItem> rules = [
    RulesItem(key: "name", desction: "名字不能为空"),
    RulesItem(
        key: "phone",
        isRequired: true,
        desction: "手机号码必须为11位",
        validation: (value) => (value as String).length == 11)
  ];

  void onSummit() {
    if (TenFrom.onValidate(rules, model, autoTip: true, context: context)
        .isEmpty) {
      TenFeedBack.showTenSnackbar(context, "校验通过",
          type: FeedbackOptionType.success());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TenAppBar(title: "表单示例"),
        body: Column(
          children: [
            TenCard(
                child: TenFrom(model: model, rules: rules, children: [
              TenFromItem(
                  label: "名字",
                  ruleKey: "name",
                  inputWidget: TenFromInput(
                    hintText: "文本输入框",
                    onChanged: (value) => model['name'] = value,
                  )),
              TenFromItem(
                  label: "电话号码",
                  help: "11位数的中国大陆手机号码才能通过检验",
                  ruleKey: "phone",
                  inputWidget: TenFromInput(
                    hintText: "TextInputType.phone",
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                    onChanged: (value) => model['phone'] = value,
                  )),
              TenFromItem(
                  label: "数量",
                  ruleKey: "number",
                  inputWidget: TenNumberInput(
                      initValue: model['number'],
                      onChange: (p0) => {print(p0)})),
              TenFromItem(
                  label: "组织会员",
                  ruleKey: "isVip",
                  inputWidget: TenSwitch(
                      value: model['isVip'] == 1 ? true : false,
                      onChanged: (value) {
                        setState(() {
                          model['isVip'] = value ? 1 : 0;
                        });
                      })),
              TenFromItem(
                  label: "所属部门",
                  inputWidget: TenFromDefaultLabel(
                    model['dropdown'],
                    onTap: () {
                      TenButtonSheet.selector(context, onSummit: (p0) {
                        setState(() {
                          model['dropdown'] = p0.key;
                        });
                      }, options: [
                        TenFromSelectorModel("月亮会", key: "月亮会"),
                        TenFromSelectorModel("太阳会", key: "太阳会"),
                        TenFromSelectorModel("星星会", key: "星星会")
                      ], defaultOptionKey: model['dropdown']);
                    },
                  )),
              TenFromItem(
                  label: "日期范围",
                  help: "此条目右侧仅为文本，依靠点击事件触发，一般如时间选择器，依靠函数触发的数据选项等",
                  inputWidget: TenFromDefaultLabel(
                      valueIsEmpty(model['dateRange'])
                          ? "选择日期范围"
                          : "${model['dateRange']}", onTap: () async {
                    List<DateTime?> dates = (await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const DatePicker(
                              calendarType: CalendarDatePicker2Type.range,
                            ),
                          ),
                        )) ??
                        [];
                    dates = dates
                        .map((e) => e != null ? DateUtils.dateOnly(e) : null)
                        .toList();
                    if (dates.isNotEmpty) {
                      final startDate =
                          dates[0].toString().replaceAll('00:00:00.000', '');
                      final endDate = dates.length > 1
                          ? dates[1].toString().replaceAll('00:00:00.000', '')
                          : ' / ';
                      setState(() {
                        model['dateRange'] = '$startDate至 $endDate';
                      });
                    }
                  })),
              TenFromItem(
                  label: "指定日期",
                  inputWidget: TenFromDefaultLabel(
                      valueIsEmpty(model['dateSingle'])
                          ? "选择一个日期"
                          : "${model['dateSingle']}", onTap: () async {
                    List<DateTime?> dates = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DatePicker(
                          calendarType: CalendarDatePicker2Type.single,
                        ),
                      ),
                    );
                    dates = dates
                        .map((e) => e != null ? DateUtils.dateOnly(e) : null)
                        .toList();
                    if (dates.isNotEmpty) {
                      final startDate =
                          dates[0].toString().replaceAll('00:00:00.000', '');
                      setState(() {
                        model['dateSingle'] = startDate;
                      });
                    }
                  })),
              TenFromItem(
                  label: "日期且时间",
                  inputWidget: TenFromDefaultLabel(
                      valueIsEmpty(model['timeSingle'])
                          ? "选择一个时间"
                          : "${model['timeSingle']}", onTap: () async {
                    final result = await showBoardDateTimePicker(
                        context: context,
                        pickerType: DateTimePickerType.datetime,
                        options: boardOption);
                    if (result != null) {
                      setState(() {
                        model['timeSingle'] =
                            "${result.year}-${result.month}-${result.day} ${result.hour}:${result.minute}";
                      });
                    }
                  })),
            ])),
            TenCard(child: TenFrom(model: model, children: [
              TenFromItem(
                  label: "单项选择",
                  help: "一般建议在新的卡片里，整体更协调",
                  inputWidget: TenRadio(
                    value: model['radio'],
                    options: [
                      TenRadioModel("微信支付", key: 0),
                      TenRadioModel("支付宝", key: 1),
                      TenRadioModel("Ios 内购", key: 2),
                    ],
                    onChange: (p0) {
                      setState(() {
                        model['radio'] = p0.key;
                      });
                    },
                  ))
            ])),
            TenCard(
                child: TenButton(
              "校验数据",
              onTap: onSummit,
            ).intrinsicWidth()),
          ],
        ).scrollView());
  }
}