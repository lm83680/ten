import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class ExampleTabs extends StatefulWidget {
  const ExampleTabs({super.key});

  @override
  State<ExampleTabs> createState() => _ExampleTabsState();
}

class _ExampleTabsState extends State<ExampleTabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Tab的数量
      child: Scaffold(
        appBar: TenAppBar(
            title: "标签页",
            bottom: TenTabs(
              tabs: [
                Tab(text: '最近关注'),
                Tab(text: '历史'),
                Tab(text: '最常访问'),
                Tab(text: '最近关注'),
              ],
            )),
        body: TabBarView(
          children: [
            ExpansionTile(
                  title: Text('Expansion Tile'),
                  children: <Widget>[
                    ListTile(title: Text('Child 1')),
                    ListTile(title: Text('Child 2')),
                  ],
                ),
            Center(child: Text('2')),
            Center(child: Text('3')),
            Center(child: Text('4')),
          ],
        ),
      ),
    );
  }
}
