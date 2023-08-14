import 'package:coding_factory_train/common/const/data.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.onChanged,
      required this.hintText,
      this.errorText,
      this.obscureText = false,  this.autoFocus=false});

  final ValueChanged<String>? onChanged;
  final String hintText;
  final String? errorText;
  final bool obscureText;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: INPUT_BORDER_COLOR));

    return TextFormField(
      obscureText: obscureText,
      onChanged: onChanged,
      autofocus: autoFocus,
      decoration: InputDecoration(
          fillColor: INPUT_BG_COLOR,
          filled: true,
          hintText: hintText,
          errorText: errorText,
          border: outlineInputBorder.copyWith(
              borderSide:
                  outlineInputBorder.borderSide.copyWith(color: Colors.red)),
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder.copyWith(
              borderSide: outlineInputBorder.borderSide
                  .copyWith(color: PRIMARY_COLOR))),
    );
  }
}
