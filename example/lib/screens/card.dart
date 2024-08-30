import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class ExampleCard extends StatelessWidget {
  const ExampleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TenAppBar(
        title: "卡片",
      ),
      body: Column(
        children: [
          const TenCard(
            child: TenListItem(
              title: "默认",
              subtitle: "默认情况下 Card 接受一个 child",
            ),
          ),
          TenCard.column(
            children: const [
              TenListItem(
                title: "常用.column扩展函数",
                subtitle: "使用.column扩展函数,会使用 card > cloumn 渲染",
              )
            ],
          ),
          const TenSection(notation: Text("#"), name: "预设:"),
          TenCardPreset(
            leading:Image.network("http://q1.qlogo.cn/g?b=qq&nk=2494966366&s=100"),
            title: "云南优质茶叶",
            subtitle: "预设卡片，常用于商品、联系人卡片",
            trailing:TenButtonBorder.wraning("加购",lefticon: Icon(Icons.shopping_cart_outlined),)
          ),
        ],
      ),
    );
  }
}
