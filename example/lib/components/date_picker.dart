import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:ten/ten.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key, this.selectableDayPredicate, this.defaultValue, this.calendarType = CalendarDatePicker2Type.single});

  ///传入日期，返回该日期是否可选。
  final bool Function(DateTime)? selectableDayPredicate;
  final List<DateTime?>? defaultValue;
  ///single: 一个日期（默认） ， range 时间范围，  multi 多个日期点（不常用）
  final CalendarDatePicker2Type calendarType;
  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.defaultValue != null) {
      setState(() {
        _rangeDatePickerValueWithDefaultValue = widget.defaultValue!;
      });
    }
  }

  Widget _buildScrollRangeDatePickerWithValue(
      CalendarDatePicker2Config config) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: CalendarDatePicker2(
          config: config,
          value: _rangeDatePickerValueWithDefaultValue,
          onValueChanged: (dates) =>
              setState(() => _rangeDatePickerValueWithDefaultValue = dates),
        )),
        const SizedBox(height: 10),
      ],
    );
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : ' / ';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : ' / ';
        valueText = '$startDate 至 $endDate';
      } else {
        return ' / ';
      }
    }

    return valueText;
  }

  @override
  Widget build(BuildContext context) {
    final config = CalendarDatePicker2Config(
        centerAlignModePicker: true,
        calendarType: widget.calendarType,
        calendarViewMode: CalendarDatePicker2Mode.day,
        selectedDayHighlightColor: TenScheme.primary,
        weekdayLabelTextStyle: TenScheme.actionM,
        weekdayLabels: ['日', "一", "二", "三", "四", "五", "六"],
        controlsTextStyle: TenScheme.actionM,
        disabledDayTextStyle: TenScheme.desction,
        selectableDayPredicate: widget.selectableDayPredicate,
        firstDate:DateTime(DateTime.now().year - 25),
        lastDate:DateTime(DateTime.now().year + 25),
        modePickerBuilder: ({required monthDate, isMonthPicker}) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: isMonthPicker == true
                    ? TenScheme.wraning
                    : TenScheme.success,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                isMonthPicker == true
                    ? "${monthDate.month} 月"
                    : "${monthDate.year} 年",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
        yearBuilder: (
            {decoration,
            isCurrentYear,
            isDisabled,
            isSelected,
            textStyle,
            required year}) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                  color: isSelected == true ? TenScheme.primary : null,
                  borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text("$year",
                  style: TenScheme.actionM.copyWith(
                      color: isSelected == true
                          ? Colors.white
                          : (isCurrentYear == true
                              ? TenScheme.success
                              : null))),
            ),
          );
        },
        monthBuilder: (
            {decoration,
            isCurrentMonth,
            isDisabled,
            isSelected,
            required month,
            textStyle}) {
          Map<int, String> monthMap = {
            1: "一月",
            2: "二月",
            3: "三月",
            4: "四月",
            5: "五月",
            6: "六月",
            7: "七月",
            8: "八月",
            9: "九月",
            10: "十月",
            11: "十一月",
            12: "十二月",
          };
          return Center(
            child: Container(
              decoration: BoxDecoration(
                  color: isSelected == true ? TenScheme.primary : null,
                  borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(monthMap[month]!,
                  style: TenScheme.actionM.copyWith(
                      color: isSelected == true
                          ? Colors.white
                          : (isCurrentMonth == true
                              ? TenScheme.success
                              : null))),
            ),
          );
        });

    return Scaffold(
      appBar: TenAppBar(
        title: {
          CalendarDatePicker2Type.single:"选择一个日期",
          CalendarDatePicker2Type.multi:"选择多个日期",
          CalendarDatePicker2Type.range:"选择一个日期范围",
        }[widget.calendarType] ?? "请选择",
      ),
      body: SafeArea(child: _buildScrollRangeDatePickerWithValue(config)),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getValueText(
                  config.calendarType,
                  _rangeDatePickerValueWithDefaultValue,
                ),
                style: TenScheme.actionM,
              ),
              TenButton.success("确定",
                  onTap: () => Navigator.pop(
                      context, _rangeDatePickerValueWithDefaultValue))
            ],
          ),
        ),
      ),
    );
  }
}
