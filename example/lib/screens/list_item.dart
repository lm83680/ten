import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class ExampleListItem extends StatelessWidget {
  const ExampleListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TenAppBar(title: "横向列表"),
        body: TenCard.column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TenSection(notation: Text("#"), name: "一般"),
            TenListItem(
              title: "仿写 ListTile",
              subtitle:
                  "采用 顶中中 的布局，用户体验感更优采用 顶中中 的布局，用户体验感更优采用 顶中中 的布局，用户体验感更优",
              leading: IconButton(
                icon: Icon(
                  Icons.headphones,
                  color: TenScheme.primary,
                ),
                onPressed: () => {},
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.navigate_next_rounded,
                  color: TenScheme.primary,
                ),
                onPressed: () => {},
              ),
            ),

            TenListItem(
              title: "无 leading 的TenListItem",
              trailing: IconButton(
                icon: Icon(
                  Icons.navigate_next_rounded,
                  color: TenScheme.primary,
                ),
                onPressed: () => {},
              ),
            ),
            TenListItem(
              title: "无 trailing 的TenListItem",
              subtitle: "无 trailing 的TenListItem",
              leading: IconButton(
                icon: Icon(
                  Icons.ice_skating,
                  color: TenScheme.primary,
                ),
                onPressed: () => {},
              ),
            ),
            const TenSection(notation: Text("#"), name: "事件"),
                        TenListItem(
              title: "无 subtitle 的TenListItem",
              subtitle: "TenListItem 仅支持 点按 和 长按 事件",
              onTap: () => {
                showTenSnackbar(context,"点按",type: FeedbackOptionType.success())
              },
              onLongPress: () => {
                showTenSnackbar(context,"长按",type: FeedbackOptionType.success())
              },
              leading: IconButton(
                icon: Icon(
                  Icons.ice_skating,
                  color: TenScheme.primary,
                ),
                onPressed: () => {},
              ),
            ),
            const TenSection(notation: Text("#"), name: "优化"),
            TenListItemStl(
              title: "TenListItemStl",
              maxLines: 6,
              subtitle:
                  "为了保持布局达到预期（顶中中），TenListItem继承了StatefulWidget用于计算部件,继承自StatelessWidget的TenListItemStl，去掉计算开销，布局均居中，若你的 ListTile 布局可接受 前中后段均居中的布局，尝试调用[TenListItemStl]",
              leading: IconButton(
                icon: Icon(
                  Icons.ice_skating,
                  color: TenScheme.primary,
                ),
                onPressed: () => {},
              ),
            ),
            const TenListItemStl(
              title: "没有leading的ListItem 更适合使用",
              maxLines: 6,
              subtitle: "虽然没有leading时不会进入计算环节",
            ),
            TenListItemStl(
              title: "TenListItemStl",
              maxLines: 6,
              subtitle:
                  "继承自StatelessWidget的TenListItemStl，去掉计算开销，布局均居中，若你的 ListTile 布局可接受 前中后段均居中的布局，尝试调用[TenListItemStl]",
              leading: IconButton(
                icon: Icon(
                  Icons.ice_skating,
                  color: TenScheme.primary,
                ),
                onPressed: () => {},
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.navigate_next_rounded,
                  color: TenScheme.primary,
                ),
                onPressed: () => {},
              ),
            ),
          ],
        ).scrollView());
  }
}
