import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class ExampleScheme extends StatelessWidget {
  const ExampleScheme({super.key});

  Widget colorBlock(Color color){
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(4))
      ),
      width: 24,
      height: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TenAppBar(title: "主题"),
      body: SingleChildScrollView(
        child:TenCard.column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TenListItem(
            title: "使用频率",
            subtitle: "右侧数值统计对应在包内被调用的次数",
          ),
          const TenSection(notation: Text("1"), name: "主题").padding(left: 16,top: 24,bottom: 16),
          TenListItem(
            title: "primary",
            leading: colorBlock(TenScheme.primary),
            subtitle: "组件的主要色",
            trailing: Text("16",style: TenScheme.desction),
          ),
          TenListItem(
            title: "primary50",
            leading: colorBlock(TenScheme.primary50),
          ),
          TenListItem(
            title: "primary100",
            leading: colorBlock(TenScheme.primary100),
          ),
          TenListItem(
            title: "primary200",
            leading: colorBlock(TenScheme.primary200),
          ),
          TenListItem(
            title: "primary300",
            leading: colorBlock(TenScheme.primary300),
            subtitle: "一般用作于带主题的背景色",
          ),
          const TenSection(notation: Text("2"), name: "中性色").padding(left: 16,top: 24,bottom: 16),
          TenListItem(
            title: "neutralLight",
            leading: colorBlock(TenScheme.neutralLight),
          ),
          TenListItem(
            title: "neutralLight50",
            leading: colorBlock(TenScheme.neutralLight50),
          ),
          TenListItem(
            title: "neutralLight100",
            leading: colorBlock(TenScheme.neutralLight100),
          ),
          TenListItem(
            title: "neutralLight200",
            leading: colorBlock(TenScheme.neutralLight200),
          ),
          const TenSection(notation: Text("3"), name: "中性色Dark").padding(left: 16,top: 24,bottom: 16),
          TenListItem(
            title: "neutralDark",
            leading: colorBlock(TenScheme.neutralDark),
          ),
          TenListItem(
            title: "neutralDark50",
            leading: colorBlock(TenScheme.neutralDark50),
          ),
          TenListItem(
            title: "neutralDark100",
            leading: colorBlock(TenScheme.neutralDark100),
          ),
          TenListItem(
            title: "neutralDark200",
            leading: colorBlock(TenScheme.neutralDark200),
          ),
          const TenSection(notation: Text("4"), name: "文字").padding(left: 16,top: 24,bottom: 16),
          TenListItem(
            title: "h1",
            leading: Text("h1",style: TenScheme.h1,),
          ),
          TenListItem(
            title: "h2",
            leading: Text("h2",style: TenScheme.h2),
          ),
          TenListItem(
            title: "h3",
            leading: Text("h3",style: TenScheme.h3),
          ),
          TenListItem(
            title: "h4",
            leading: Text("h4",style: TenScheme.h4),
          ),
          TenListItem(
            title: "action",
            leading: Text("action",style: TenScheme.action,),
          ),
          TenListItem(
            title: "actionM",
            leading: Text("actionM",style: TenScheme.actionM),
          ),
          TenListItem(
            title: "actionS",
            leading: Text("actionS",style: TenScheme.actionS),
          ),
          TenListItem(
            title: "caption",
            leading: Text("caption",style: TenScheme.caption),
          ),
          TenListItem(
            title: "desction",
            leading: Text("desction",style: TenScheme.desction),
          ),
        ].withSeparator(),
      )),
    );
  }
}
