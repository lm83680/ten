import 'package:flutter/widgets.dart';
import 'package:ten/style/index.dart';
import 'package:ten/ten.dart';

///一个平平无奇的容器标题容器，一般用作某些 List 的标题
class TenSection extends StatelessWidget {
  const TenSection({this.notation, required this.name, super.key});
  final Widget? notation;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: TenScheme.neutralLight100,
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      padding: const EdgeInsets.all(6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (notation != null)
            Container(
                decoration: BoxDecoration(
                  color: TenScheme.neutralLight50,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                width: 36,
                height: 36,
                child: Center(child: notation!)),
          Text(
              name,
              style: TenScheme.h4,
            ).padding(left: 12,right: 12)
        ],
      ),
    );
  }
}
