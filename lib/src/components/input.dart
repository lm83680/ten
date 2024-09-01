import 'package:flutter/material.dart';
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
      super.key});
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final bool readOnly = false;
  final int? maxLength;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;

  final String? hintText;
  // Color? cursorColor,
  // Color? cursorErrorColor,

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      readOnly:readOnly,
      textAlign: TextAlign.right,
      maxLength: maxLength,
      cursorColor:TenScheme.primary,
      cursorErrorColor: TenScheme.error,
      cursorRadius:const Radius.circular(8),
      cursorOpacityAnimates: true,
      onSubmitted: onSubmitted,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText, 
        hintStyle: TenScheme.action.copyWith(color: TenScheme.neutralLight),
        border: InputBorder.none,
        counterText: "",
       ),
    );
  }
}
