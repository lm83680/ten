import 'package:example/screens/index.dart';
import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white)),
    debugShowCheckedModeBanner: false,
    home: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static List<ExampleItem> list = [
    ExampleItem(title: "非组件", subItem: [
      ExampleSubItem("Scheme 主题", ExampleScheme()),
      ExampleSubItem("Extemsion 部件拓展", ExampleExtension()),
      ExampleSubItem("Feedback 交互反馈", ExampleFeedBack())
    ]),
    ExampleItem(title: "基础", subItem: [
      ExampleSubItem("Button 通用按钮", ExampleButton()),
      ExampleSubItem("Divider 分割线", ExampleTenDivider()),
      ExampleSubItem("Tooltip 气泡", ExampleTooltip()),
      ExampleSubItem("Guide 引导", ExampleGuide()),
    ]),
    ExampleItem(title: "容器", subItem: [
      ExampleSubItem("ListItem 横向列表", ExampleListItem()),
      ExampleSubItem("Card 卡片", ExampleCard()),
    ]),
    ExampleItem(title: "导航栏", subItem: [
      ExampleSubItem("Appbar 导航栏", ExampleTenAppbar()),
    ]),
    ExampleItem(title: "内容", subItem: [
      ExampleSubItem("Tag 标签", ExampleTag()),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: list.asMap().entries.map((entry) {
              int index = entry.key;
              ExampleItem item = entry.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TenSection(notation: Text("$index"), name: item.title)
                      .padding(left: 16, top: 24),
                  TenCard(
                    child: Column(
                      children: item.subItem
                          .map((subElement) {
                            return TenListItem(
                                onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => subElement.page,
                                      ),
                                    ),
                                title: subElement.name,
                                trailing:
                                    const Icon(Icons.navigate_next_rounded));
                          })
                          .toList()
                          .withSeparator(),
                    ),
                  )
                ],
              );
            }).toList()),
      )),
    );
  }
}

class ExampleItem {
  String title;
  List<ExampleSubItem> subItem;
  ExampleItem({required this.title, required this.subItem});
}

class ExampleSubItem {
  String name;
  Widget page;

  ExampleSubItem(this.name, this.page);
}
