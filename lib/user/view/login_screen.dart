import 'dart:convert';

import 'package:coding_factory_train/common/component/custom_text_field.dart';
import 'package:coding_factory_train/common/const/colors.dart';
import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/const/util.dart';
import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:coding_factory_train/common/secure_storage/secure_storage.dart';
import 'package:coding_factory_train/common/view/roor_tap.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final Dio dio = Dio();
  String username = "";
  String password = "";

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
                CustomTextField(
                  hintText: "아이디를 입력하세요",
                  onChanged: (String value) {
                    username = value;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: "비밀번호를 입력하세요",
                  obscureText: true,
                  onChanged: (String value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () async {
                      String rawString = "$username:$password";
                      Codec<String, String> stringToBase64 = utf8.fuse(base64);
                      String token = stringToBase64.encode(rawString);

                      final resp = await dio.post("$serverUrl/auth/login",
                          options: Options(
                              headers: {"authorization": "Basic $token"}));

                      final String accessToken = resp.data["accessToken"];
                      final String refreshToken = resp.data["refreshToken"];

                      final storage = ref.watch(secureStorageProvider);

                      await storage.write(
                          key: ACCESS_TOKEN, value: accessToken);
                      await storage.write(
                          key: REFRESH_TOKEN, value: refreshToken);
                      logger.d(await storage.read(key: ACCESS_TOKEN));
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => RootTap()),
                          (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR),
                    child: const Text(
                      "로그인",
                      style: TextStyle(color: Colors.white),
                    )),
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
