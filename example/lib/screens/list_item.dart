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
            TenListITile(
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

            TenListITile(
              title: "无 leading 的TenListITile",
              trailing: IconButton(
                icon: Icon(
                  Icons.navigate_next_rounded,
                  color: TenScheme.primary,
                ),
                onPressed: () => {},
              ),
            ),
            TenListITile(
              title: "无 trailing 的TenListITile",
              subtitle: "无 trailing 的TenListITile",
              leading: IconButton(
                icon: Icon(
                  Icons.ice_skating,
                  color: TenScheme.primary,
                ),
                onPressed: () => {},
              ),
            ),
            const TenSection(notation: Text("#"), name: "事件"),
                        TenListITile(
              title: "无 subtitle 的TenListITile",
              subtitle: "TenListITile 仅支持 点按 和 长按 事件",
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
          ],
        ).scrollView());
  }
}
