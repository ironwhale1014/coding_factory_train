import 'package:coding_factory_train/common/const/color.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final String? errorText;

  const CustomTextFormField({
    super.key,
    this.obscureText = false,
    this.autofocus = false,
    required this.onChanged,
    this.hintText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    const baseBorder = OutlineInputBorder(
        borderSide: BorderSide(width: 1.0, color: INPUT_BORDER_COLOR));

    return TextFormField(
      obscureText: obscureText,
      autofocus: autofocus,
      onChanged: onChanged,
      cursorColor: PRIMATY_COLOR,
      decoration: InputDecoration(
          hintText: hintText,
          errorText: errorText,
          contentPadding: const EdgeInsets.all(16),
          hintStyle: const TextStyle(fontSize: 14, color: BODY_TEXT_COLOR),
          fillColor: INPUT_BG_COLOR,
          filled: true,
          border: baseBorder,
          enabledBorder: baseBorder,
          focusedBorder: baseBorder.copyWith(
            borderSide: baseBorder.borderSide.copyWith(color: PRIMATY_COLOR),
          )),
    );
  }
}
