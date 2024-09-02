import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ten/style/index.dart';
import 'package:ten/ten.dart';

class TenFromInput extends StatelessWidget {
  const TenFromInput(
      {this.controller,
      this.focusNode,
      this.keyboardType = TextInputType.text,
      this.maxLength,
      this.onChanged,
      this.onEditingComplete,
      this.onSubmitted,
      this.hintText,
      this.rge,
      this.maxLine,
      super.key});
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final bool readOnly = false;
  final int? maxLength;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;
  final int? maxLine;

  ///输入框限制正则表达式，默认不限制
  final String? rge;

  final String? hintText;
  // Color? cursorColor,
  // Color? cursorErrorColor,

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      readOnly: readOnly,
      textAlign: maxLine != null && maxLine !=1 ? TextAlign.start : TextAlign.right,
      maxLength: maxLength,
      maxLines: maxLine,
      cursorColor: TenScheme.primary,
      cursorErrorColor: TenScheme.error,
      cursorRadius: const Radius.circular(8),
      cursorOpacityAnimates: true,
      onSubmitted: onSubmitted,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      inputFormatters: rge == null
          ? null
          : [FilteringTextInputFormatter.allow(RegExp(rge!))],
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TenScheme.action.copyWith(color: TenScheme.neutralLight),
        border: InputBorder.none,
        counterText: "",
      ),
    );
  }
}

class TenNumberInput extends StatefulWidget {
  const TenNumberInput({
    this.initValue,
    required this.onChange,
    this.step = 1,
    this.min = 0,
    this.max = 9999,
    this.width = 48,
    this.rge = r'^[0-9]*$',
    super.key,
  });

  ///步进数 - 默认 1
  final int step;
  final int? initValue;
  final void Function(int) onChange;

  final int min;
  final int max;
  final double width;

  ///输入框限制正则表达式，默认仅允许任意正整数
  final String rge;
  @override
  State<TenNumberInput> createState() => _TenNumberInputState();
}

class _TenNumberInputState extends State<TenNumberInput> {
  TextEditingController controller = TextEditingController();
  int lastValue = 0;
  @override
  void initState() {
    setState(() {
      lastValue = widget.initValue ?? 0;
      controller.text = lastValue.toString();
    });
    super.initState();
  }

  void add() {
    controller.text = (int.parse(controller.text) + widget.step).toString();
    input(controller.text);
  }

  void remove() {
    controller.text = (int.parse(controller.text) - widget.step).toString();
    input(controller.text);
  }

  void input(String value) {
    value = value.replaceFirst(RegExp(r'^0+'), '');
    if (value.isEmpty) {
      if (lastValue != widget.min) {
        widget.onChange(widget.min);
      }
      setState(() {
        controller.text = widget.min.toString();
      });
      lastValue = widget.min;
      return;
    }

    int number = int.parse(value);
    if (number > widget.max) {
      number = widget.max;
    } else if (number < widget.min) {
      number = widget.min;
    }

    if (number.toString() != controller.text) {
      setState(() {
        controller.text = number.toString();
      });
    }
    if (lastValue != number) {
      widget.onChange(number);
    }

    lastValue = number;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: remove,
          child: Container(
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
                color: TenScheme.primary300,
                borderRadius: BorderRadius.circular(14)),
            padding: const EdgeInsets.all(4),
            child: Icon(
              Icons.remove,
              color: TenScheme.primary,
              size: 14,
            ),
          ),
        ),
        SizedBox(
            width: widget.width,
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TenScheme.action.copyWith(height: 1),
              controller: controller,
              onChanged: input,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(widget.rge)),
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            )),
        GestureDetector(
            onTap: add,
            child: Container(
                decoration: BoxDecoration(
                    color: TenScheme.primary300,
                    borderRadius: BorderRadius.circular(14)),
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.add,
                  color: TenScheme.primary,
                  size: 14,
                ))),
      ],
    );
  }
}
