import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:example/components/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ten/style/index.dart';
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
    "timeSingle": ""
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
      showTenSnackbar(context, "校验通过", type: FeedbackOptionType.success());
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
                  inputInput: TenFromInput(
                    hintText: "文本输入框",
                    onChanged: (value) => model['name'] = value,
                  )),
              TenFromItem(
                  label: "电话号码",
                  help: "11位数的中国大陆手机号码才能通过检验",
                  ruleKey: "phone",
                  inputInput: TenFromInput(
                    hintText: "TextInputType.phone",
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                    onChanged: (value) => model['phone'] = value,
                  )),
              TenFromItem(
                  label: "数量",
                  ruleKey: "number",
                  inputInput: TenNumberInput(
                      initValue: model['number'],
                      onChange: (p0) => {print(p0)})),
              TenFromItem(
                  label: "组织会员",
                  ruleKey: "isVip",
                  inputInput: TenSwitch(
                      value: model['isVip'] == 1 ? true : false,
                      onChanged: (value) {
                        setState(() {
                          model['isVip'] = value ? 1 : 0;
                        });
                      })),
              TenFromItem(
                  label: "所属部门",
                  inputInput: TenDropdownButton(
                    value: model['dropdown'],
                    onChanged: (value) {
                      setState(() {
                        model['dropdown'] = value;
                      });
                    },
                    items: [
                      TenDropdownMenuItem(
                          value: "月亮会", enabled: false, label: "月亮会"),
                      TenDropdownMenuItem(value: "太阳会", label: "太阳会"),
                      TenDropdownMenuItem(
                          value: "星星会",
                          icon: const Icon(Icons.star_border_purple500_rounded),
                          label: "星星会")
                    ],
                  )),
              TenFromItem(
                  label: "日期范围",
                  help: "此条目右侧仅为文本，依靠点击事件触发，一般如时间选择器，依靠函数触发的数据选项等",
                  inputInput: TenFromDefaultLabel(
                      valueIsEmpty(model['dateRange'])
                          ? "选择日期范围"
                          : "${model['dateRange']}", onTap: () async {
                    List<DateTime?> dates = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DatePicker(
                          calendarType: CalendarDatePicker2Type.range,
                        ),
                      ),
                    );
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
                  inputInput: TenFromDefaultLabel(
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
                  inputInput: TenFromDefaultLabel(
                      valueIsEmpty(model['timeSingle'])
                          ? "选择一个时间"
                          : "${model['timeSingle']}", onTap: () async {
                    final result = await showBoardDateTimePicker(
                        context: context,
                        pickerType: DateTimePickerType.datetime,
                        options: BoardDateTimeOptions(
                          foregroundColor: Colors.white,
                          activeColor:TenScheme.primary,
                          inputable: false,
                          weekend: BoardPickerWeekendOptions(
                            saturdayColor: TenScheme.success,
                            sundayColor: TenScheme.success
                          ),
                          languages: BoardPickerLanguages(
                            locale: 'zh',
                            today: '今天',
                            tomorrow: '明天',
                            now: '现在',
                          ),
                        ));
                    if (result != null) {
                      setState(() {
                        model['timeSingle'] = "${result.year}-${result.month}-${result.day} ${result.hour}:${result.minute}";
                      });
                    }
                  }))
            ])),
            TenCard(
                child: TenButton(
              "校验数据",
              onTap: onSummit,
            ).intrinsicWidth())
          ],
        ));
  }
}
