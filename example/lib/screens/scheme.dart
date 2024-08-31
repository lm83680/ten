import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class ExampleScheme extends StatelessWidget {
  const ExampleScheme({super.key});

  Widget colorBlock(Color color) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      width: 24,
      height: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TenAppBar(title: "主题"),
      body: SingleChildScrollView(
          child: TenCard.column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TenButton(
                "尝试更改主题",
                onTap: () {
                  TenScheme().setScheme(Colors.orangeAccent);
                  showTenSnackbar(context, "设置成功",
                      type: FeedbackOptionType.success());
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ExampleScheme()),
                  );
                },
              ),
              TenButton(
                "恢复默认",
                onTap: () {
                  TenScheme().setScheme(Color(0xff006ffd));
                  showTenSnackbar(context, "设置成功",
                      type: FeedbackOptionType.success());
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ExampleScheme()),
                  );
                },
              ),
            ],
          ).padding(bottom: 16),
          TenListITile(
            title: "全局性",
            subtitle:
                "在任意点调用TenScheme().setScheme(Color) 都能生成新的配色，但Ten库主要依赖primary，其余配色暂不支持修改，也不建议修改",
          ),
          const TenSection(notation: Text("1"), name: "主题")
              .padding(left: 16, top: 24, bottom: 16),
          TenListITile(
            title: "primary",
            leading: colorBlock(TenScheme.primary),
            subtitle: "组件的主要色",
          ),
          TenListITile(
            title: "primary50",
            leading: colorBlock(TenScheme.primary50),
            subtitle: "一般不需要这个颜色，可以作为主色的协调色",
          ),
          TenListITile(
            title: "primary100",
            leading: colorBlock(TenScheme.primary100),
            subtitle: "一般也不需要这个颜色，可以作为主色的协调色",
          ),
          TenListITile(
            title: "primary200",
            leading: colorBlock(TenScheme.primary200),
            subtitle: "需要展示主题色但需要弱化存在感时使用",
          ),
          TenListITile(
            title: "primary300",
            leading: colorBlock(TenScheme.primary300),
            subtitle: "一般用作于带主题的背景色，例如空组件的背景色、注意，这个颜色是不具有透明度的",
          ),
          TenListITile(
            title: "primaryOpacity",
            leading: colorBlock(TenScheme.primary300Opacity),
            subtitle: "作为涟漪色，该色值是primary200.withOpacity(0.4)，注意，这个颜色是具有透明度的，所以才可以作为涟漪色",
          ),
          const TenSection(notation: Text("2"), name: "中性色")
              .padding(left: 16, top: 24, bottom: 16),
          TenListITile(
            title: "neutralLight",
            leading: colorBlock(TenScheme.neutralLight),
          ),
          TenListITile(
            title: "neutralLight50",
            leading: colorBlock(TenScheme.neutralLight50),
          ),
          TenListITile(
            title: "neutralLight100",
            leading: colorBlock(TenScheme.neutralLight100),
          ),
          TenListITile(
            title: "neutralLight200",
            leading: colorBlock(TenScheme.neutralLight200),
          ),
          const TenSection(notation: Text("3"), name: "中性色Dark")
              .padding(left: 16, top: 24, bottom: 16),
          TenListITile(
            title: "neutralDark",
            leading: colorBlock(TenScheme.neutralDark),
          ),
          TenListITile(
            title: "neutralDark50",
            leading: colorBlock(TenScheme.neutralDark50),
          ),
          TenListITile(
            title: "neutralDark100",
            leading: colorBlock(TenScheme.neutralDark100),
          ),
          TenListITile(
            title: "neutralDark200",
            leading: colorBlock(TenScheme.neutralDark200),
          ),
          const TenSection(notation: Text("4"), name: "文字")
              .padding(left: 16, top: 24, bottom: 16),
          TenListITile(
            title: "h1",
            leading: Text(
              "h1",
              style: TenScheme.h1,
            ),
          ),
          TenListITile(
            title: "h2",
            leading: Text("h2", style: TenScheme.h2),
          ),
          TenListITile(
            title: "h3",
            leading: Text("h3", style: TenScheme.h3),
          ),
          TenListITile(
            title: "h4",
            leading: Text("h4", style: TenScheme.h4),
          ),
          TenListITile(
            title: "action",
            leading: Text(
              "action",
              style: TenScheme.action,
            ),
          ),
          TenListITile(
            title: "actionM",
            leading: Text("actionM", style: TenScheme.actionM),
          ),
          TenListITile(
            title: "actionS",
            leading: Text("actionS", style: TenScheme.actionS),
          ),
          TenListITile(
            title: "caption",
            leading: Text("caption", style: TenScheme.caption),
          ),
          TenListITile(
            title: "desction",
            leading: Text("desction", style: TenScheme.desction),
          ),
        ].withSeparator(),
      )),
    );
  }
}
