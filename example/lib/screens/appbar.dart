import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class ExampleTenAppbar extends StatelessWidget {
  const ExampleTenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2, // Tab的数量
        child: Scaffold(
            appBar: TenAppBar(title: "导航栏", action: Text("custom")),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TenAppBar(
                  title: "自定义返回文字",
                  backText: "取消",
                ),
                Expanded(
                    child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      TenAppBar.sliver(
                          title: "TenAppBar.sliver",
                          bottom: TenTabs(
                            tabs: [
                              Tab(text: 'Flutter'),
                              Tab(text: 'React'),
                            ],
                          ))
                    ];
                  },
                  body: TabBarView(
                    children: [
                      ListView.builder(
                        itemCount: 30,
                        itemBuilder: (context, index) => ListTile(
                          title: Text('Flutter Item $index'),
                        ),
                      ),
                      ListView.builder(
                        itemCount: 30,
                        itemBuilder: (context, index) => ListTile(
                          title: Text('React Item $index'),
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            )));
  }
}
