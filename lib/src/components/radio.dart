import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

class TenRadioModel {
  final dynamic key;
  final String value;
  TenRadioModel(this.value, {required this.key});
}

class TenRadio extends StatelessWidget {
  const TenRadio(
      {super.key,
      required this.onChange,
      this.value,
      required this.options,
      this.labelHeigth = 20});
  final void Function(TenRadioModel) onChange;
  final dynamic value;
  final List<TenRadioModel> options;
  final double labelHeigth;
  @override
  Widget build(BuildContext context) {
    dynamic val = value ?? options[0].key;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(options.length, (int index) {
        final TenRadioModel item = options[index];
        final bool isSelected = item.key == val;
        final Color textColor = isSelected ? TenScheme.primary : TenScheme.neutralDark;
        return InkWell(
          onTap: () {
            if (!isSelected) {
              onChange(item);
            }
          },
          borderRadius: BorderRadius.circular(12),
          splashColor: TenScheme.primary300Opacity,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: IconTheme(
                  data: IconThemeData(color: textColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(item.value,style: TenScheme.action.copyWith(color: textColor, height: 1)),
                      SizedBox(
                          height: labelHeigth,
                          width: 56,
                          child: isSelected ? const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.check),
                          ): null) ,
                    ],
                  ))),
        );
      }),
    );
  }
}
