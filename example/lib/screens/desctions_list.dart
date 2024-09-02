import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class ExampleDesctionsList extends StatelessWidget {
  const ExampleDesctionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TenAppBar(title: "描述列表"),
        body: Column(children: [
          TenCard.column(
            children: [
              TenDesctionsList(list: [
                TenDesctionsItemModel("卡号", "645006980008888"),
                TenDesctionsItemModel("开户行", "上海浦发银行"),
                TenDesctionsItemModel("账户名称", "张三"),
                TenDesctionsItemModel("账户类型", "储蓄卡"),
                TenDesctionsItemModel("余额", "￥10,000.00"),
                TenDesctionsItemModel("开户日期", "2023-01-01"),
                TenDesctionsItemModel("身份证号", "310XXXXXXXXXXXXXXX"),
                TenDesctionsItemModel("联系电话", "138XXXXXXXX"),
                TenDesctionsItemModel("电子邮箱", "zhangsan@example.com"),
                TenDesctionsItemModel("账单日", "每月5日"),
                TenDesctionsItemModel("还款日", "每月15日"),
                TenDesctionsItemModel("信用额度", "￥50,000.00"),
                TenDesctionsItemModel("卡号", "645006980008888"),
                TenDesctionsItemModel("开户行", "上海浦发银行"),
                TenDesctionsItemModel("账户名称", "张三"),
                TenDesctionsItemModel("账户类型", "储蓄卡"),
                TenDesctionsItemModel("余额", "￥10,000.00"),
                TenDesctionsItemModel("开户日期", "2023-01-01"),
              ]),
            ],
          ),
          TenCard(
              padding: EdgeInsets.zero,
              child: TenListITile(
                onTap: () {},
                title: "查看联系方式",
                trailing: const Icon(Icons.navigate_next_rounded),
              ))
        ]).scrollView());
  }
}
