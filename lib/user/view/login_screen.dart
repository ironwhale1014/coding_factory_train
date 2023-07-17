import 'package:coding_factory_train/common/component/custom_text_field.dart';
import 'package:coding_factory_train/common/const/colors.dart';
import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultLayout(
      child: SafeArea(
        top: true,
        bottom: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _title(),
                const SizedBox(height: 16),
                const _subTitle(),
                Image.asset("asset/img/misc/logo.png", width: size.width),
                CustomTextField(hintText: "아이디를 입력하세요"),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: "비밀번호를 입력하세요",
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                ElevatedButton(onPressed: () {}, child: const Text("로그인")),
                TextButton(onPressed: () {}, child: const Text("화원가입")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _title extends StatelessWidget {
  const _title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      "환영합니다.",
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
    );
  }
}

class _subTitle extends StatelessWidget {
  const _subTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "이메일과 비밀번호를 입력해서 로그인 해주세요\n오늘도 성공적인 주문이 되길 :).",
      style: TextStyle(fontSize: 16, color: BODY_TEXT_COLOR),
    );
  }
}
