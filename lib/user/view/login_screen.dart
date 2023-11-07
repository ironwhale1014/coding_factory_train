import 'dart:convert';

import 'package:coding_factory_train/common/component/custom_textformfield.dart';
import 'package:coding_factory_train/common/const/colors.dart';
import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:coding_factory_train/common/secure_storage/secure_storage.dart';
import 'package:coding_factory_train/common/view/root_tap.dart';
import 'package:coding_factory_train/user/model/user_model.dart';
import 'package:coding_factory_train/user/provider/user_me_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static String get routeName => "login";

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userMeProvider);
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
                hintText: "이메일을 입력해주세요",
                onChanged: (String value) {
                  username = value;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                  hintText: "비밀번호를 입력해주세요",
                  onChanged: (String value) {
                    password = value;
                  },
                  obscureText: true),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: state is UserModelLoading
                    ? null
                    : () async {
                        ref
                            .read(userMeProvider.notifier)
                            .login(id: username, pw: password);
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const RootTap()));
                      },
                style: ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR),
                child: const Text("로그인"),
              ),
              TextButton(
                  onPressed: () async {},
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  child: const Text("회원가입"))
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
