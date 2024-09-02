import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:ten/ten.dart';

BoardDateTimeOptions boardOption = BoardDateTimeOptions(
  foregroundColor: Colors.white,
  activeColor: TenScheme.primary,
  inputable: false,
  weekend: BoardPickerWeekendOptions(
      saturdayColor: TenScheme.success, sundayColor: TenScheme.success),
  languages: BoardPickerLanguages(
    locale: 'zh',
    today: '今天',
    tomorrow: '明天',
    now: '现在',
  ),
);
