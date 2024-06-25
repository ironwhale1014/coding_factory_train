import 'dart:convert';

import 'package:coding_factory_train/common/component/custom_text_form_field.dart';
import 'package:coding_factory_train/common/const/color.dart';
import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:coding_factory_train/common/secure/secure_storage.dart';
import 'package:coding_factory_train/common/util/logger.dart';
import 'package:coding_factory_train/common/view/root_tap.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String userName = "";
  String password = "";

  final Dio dio = Dio();

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
                    hintText: "이메일을 입력하세요",
                    onChanged: (String value) {
                      userName = value;
                    }),
                const SizedBox(height: 16),
                CustomTextFormField(
                  obscureText: true,
                    hintText: "비밀번호를 입력하세요",
                    onChanged: (String value) {
                      password = value;
                    }),
                const SizedBox(height: 16),
                //TODO: 로그인 로직 구현
                ElevatedButton(
                    onPressed: () async {
                      String rawString = "$userName:$password";
                      // final rawString = 'test@codefactory.ai:testtest';
                      logger.d(rawString);
                      final stringToBase64 = utf8.fuse(base64);
                      final String token = stringToBase64.encode(rawString);


                      //TODO: 로그인 할때는 Basic으로 해야됨
                      final response = await dio.post("$serverUrl/auth/login",
                          options: Options(
                              headers: {"Authorization": "Basic $token"}));
                      final String accessToken = response.data["accessToken"];
                      final String refreshToken = response.data["refreshToken"];
                      logger.d("accessToken: $accessToken");
                      logger.d("refreshToken: $refreshToken");

                      final storage = ref.read(flutterSecureStorageProvider);
                      await storage.write(
                          key: ACCESS_TOKEN, value: accessToken);
                      await storage.write(
                          key: REFRESH_TOKEN, value: refreshToken);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const RootTap()),
                          (root) => false);
                    },
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
