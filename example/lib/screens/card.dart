import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class ExampleCard extends StatelessWidget {
  const ExampleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TenAppBar(
        title: "卡片",
      ),
      body: Column(
        children: [
          const TenSection(notation: Text("#"), name: "默认"),
          const TenCard(
            child: TenListITile(
              title: "默认",
              subtitle: "默认情况下 Card 接受一个 child",
            ),
          ),
          TenCard.column(
            children: const [
              TenListITile(
                title: "常用.column扩展函数",
                subtitle: "使用.column扩展函数,会使用 card > cloumn 渲染",
              )
            ],
          ),
          const TenSection(notation: Text("#"), name: "预设"),
          TenCardPreset(
              backgorund: Image.network(
                  "https://images.pexels.com/photos/15352968/pexels-photo-15352968.jpeg?auto=compress&cs=tinysrgb&w=400",
                  fit: BoxFit.fill),
              aspectRatio: 7 / 4,
              title: "TenCardPreset2",
              subtitle: "预设卡片`TenCardPreset2`，常用于商品、文章、活动卡片",
              description: "这是一段附加的文字描述，你可以设置aspectRatio控制图像的比例",
              tag: TenTag("热卖榜 NO.1",backgorundColor: Color(0XFFDD3333),plain: true,),
              bottom: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TenButtonBorder(
                    "加购",
                    lefticon: Icon(
                      Icons.shopping_cart_outlined,
                      color: TenScheme.primary,
                    ),
                    onTap: () {},
                  ),
                  TenButton(
                    "立即下单",
                    lefticon: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                    onTap: () {},
                  )
                ].withIntervals(wSize: 16),
              )),
        ],
      ).scrollView(),
    );
  }
}
