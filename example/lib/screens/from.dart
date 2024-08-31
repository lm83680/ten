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
    "heigth": 170,
    "isVip": 1
  };
  List<RulesItem> rules = [
    RulesItem(name: "name", desction: "名字不能为空"),
    RulesItem(
        name: "phone",
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
        appBar: TenAppBar(
            title: "表单示例"),
        body: Column(
          children: [
            TenCard(
                child: TenFrom(model: model, rules: rules, children: [
              TenFromItem(
                  label: "名字",
                  modelKey: "name",
                  inputInput: TextField(
                    onChanged: (value) => model['name'] = value,
                  )),
              TenFromItem(
                  label: "电话号码",
                  help: "11位数的中国大陆手机号码才能通过检验",
                  modelKey: "phone",
                  inputInput:
                      TextField(onChanged: (value) => model['phone'] = value)),
              TenFromItem(
                  label: "身高", modelKey: "heigth", inputInput: TextField()),
              TenFromItem(
                  label: "性别",
                  modelKey: "isVip",
                  inputInput: Switch(
                      value: model['isVip'] == 1 ? true : false,
                      onChanged: (value) {
                        setState(() {
                          model['isVip'] = value ? 1 : 0;
                        });
                      })),
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
