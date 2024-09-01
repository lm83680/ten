import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:ten/ten.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key, this.selectableDayPredicate, this.defaultValue});
  // final bool Function(({required monthDate, isMonthPicker})) modePickerTextHandler;
  final bool Function(DateTime)? selectableDayPredicate;
  final List<DateTime?>? defaultValue;
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
    if(widget.defaultValue!=null){
      setState(() {
        _rangeDatePickerValueWithDefaultValue = widget.defaultValue!;
      });
    }
  }

  Widget _buildScrollRangeDatePickerWithValue(CalendarDatePicker2Config  config) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: CalendarDatePicker2(
          config: config,
          value: _rangeDatePickerValueWithDefaultValue,
          onValueChanged: (dates) => setState(() => _rangeDatePickerValueWithDefaultValue = dates),
        )),
        const SizedBox(height: 10),
      ],
    );
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values = values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
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
      calendarType: CalendarDatePicker2Type.range,
      calendarViewMode: CalendarDatePicker2Mode.scroll,
      selectedDayHighlightColor: TenScheme.primary,
      weekdayLabelTextStyle: TenScheme.actionM,
      weekdayLabels: ['日', "一", "二", "三", "四", "五", "六"],
      controlsTextStyle: TenScheme.actionM,
      dynamicCalendarRows: true,
      disabledDayTextStyle: TenScheme.desction,
      selectableDayPredicate: widget.selectableDayPredicate,
    );

    return Scaffold(
      appBar: TenAppBar(
        title: "选择一个日期范围",
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
              TenButton.success("确定", onTap: () => Navigator.pop(context, _rangeDatePickerValueWithDefaultValue))
            ],
          ),
        ),
      ),
    );
  }
}
