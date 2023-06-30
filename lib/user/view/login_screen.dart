import 'package:coding_factory_train/common/component/custom_textformfield.dart';
import 'package:coding_factory_train/common/const/colors.dart';
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
              _Title(),
              SizedBox(height: 16),
              _SubTitle(),
              Image.asset("asset/img/misc/logo.png",
                  width: MediaQuery.of(context).size.width / 3 * 2),
              CustomTextFormField(
                hintText: "이메일을 입력해주세요",
                onChanged: (String value) {},
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                  hintText: "비밀번호를 입력해주세요",
                  onChanged: (String value) {},
                  obscureText: true),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Text("로그인"),
                style: ElevatedButton.styleFrom(backgroundColor: PRIMATY_COLOR),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text("회원가입"),
                  style: TextButton.styleFrom(foregroundColor: Colors.black))
            ],
          ),
        ),
      ),
    ));
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "환영합니다.",
      style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "이메일과 비밀번호를 입력해서 로그인 해주세요\n오늘도 성공적인 주문이 되길 :)",
      style: TextStyle(fontSize: 16, color: BODY_TEXT_COLOR),
    );
  }
}
