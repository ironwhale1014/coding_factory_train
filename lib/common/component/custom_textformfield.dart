import 'package:coding_factory_train/common/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String? hintText;
  String? errorText;
  bool obscureText;
  bool autofocus;
  ValueChanged<String>? onChanged;

  CustomTextFormField(
      {Key? key,
      this.hintText,
      this.errorText,
      this.autofocus = false,
      this.obscureText = false,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
        borderSide: BorderSide(width: 1.0, color: INPUT_BORDER_COLOR));

    return TextFormField(
      obscureText: obscureText,
      autofocus: autofocus,
      onChanged: onChanged,
      cursorColor: PRIMARY_COLOR,
      decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.all(16),
          hintStyle: const TextStyle(color: BODY_TEXT_COLOR, fontSize: 14),
          errorText: errorText,
          fillColor: INPUT_BG_COLOR,
          filled: true,
          border: baseBorder,
          enabledBorder: baseBorder,
          focusedBorder: baseBorder.copyWith(
              borderSide:
                  baseBorder.borderSide.copyWith(color: PRIMARY_COLOR))),
    );
  }
}
