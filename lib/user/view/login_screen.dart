import 'package:coding_factory_train/common/component/custom_text_form_field.dart';
import 'package:coding_factory_train/common/const/color.dart';
import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Title(),
                const SizedBox(height: 16),
                const _SubTitle(),
                Image.asset("asset/img/misc/logo.png",
                    width: MediaQuery.of(context).size.width / 3 * 2),
                CustomTextFormField(
                    hintText: "이메일을 입력하세요", onChanged: (String value) {}),
                const SizedBox(height: 16),
                CustomTextFormField(
                    hintText: "비밀번호를 입력하세요", onChanged: (String value) {}),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMATY_COLOR),
                    child: const Text(
                      "로그인",
                      style: TextStyle(color: Colors.white),
                    )),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  child: const Text("회원가입"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "환영합니다.",
      style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "이메일과 비밀번호를 입력해서 로그인 해주세요\n오늘도 성공적인 주문이 되길 :)",
      style: TextStyle(fontSize: 16, color: BODY_TEXT_COLOR),
    );
  }
}
