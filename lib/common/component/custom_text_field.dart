import 'package:coding_factory_train/common/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool autofocus;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  CustomTextField({
    super.key,
    this.hintText,
    this.errorText,
    this.autofocus = false,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const InputBorder baseBoder = OutlineInputBorder(
        borderSide: BorderSide(color: INPUT_BORDER_COLOR, width: 1));

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      autofocus: autofocus,
      obscureText: obscureText,

      onChanged: onChanged,

      //데코레이션
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          hintText: hintText,
          errorText: errorText,
          hintStyle: const TextStyle(color: BODY_TEXT_COLOR, fontSize: 14),
          border: baseBoder,
          enabledBorder: baseBoder,
          focusedBorder: baseBoder.copyWith(
              borderSide: baseBoder.borderSide.copyWith(color: PRIMARY_COLOR)),
          fillColor: INPUT_BG_COLOR,
          filled: true),
    );
  }
}
