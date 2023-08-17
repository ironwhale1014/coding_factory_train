import 'dart:convert';

import 'package:coding_factory_train/common/component/custom_textfield.dart';
import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/dio/dio.dart';
import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:coding_factory_train/common/secure/secure_storage.dart';
import 'package:coding_factory_train/common/view/root_tap.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dio = ref.watch(dioProvider);
    final storage = ref.watch(secureStorageProvider);
    Size size = MediaQuery.of(context).size;
    return DefaultLayout(
      body: SafeArea(
        top: true,
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                const _Title(),
                const SizedBox(height: 16),
                const _SubTitle(),
                Image.asset(
                  "asset/img/misc/logo.png",
                  width: size.width,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  autoFocus: true,
                  hintText: "이메일을 입력해주세요",
                  onChanged: (val) {
                    username = val;
                  },
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  hintText: "비밀번호를 입력해주세요",
                  obscureText: true,
                  onChanged: (val) {
                    password = val;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String rawData = "$username:$password";
                    final Codec<String, String> stringToBase64 =
                        utf8.fuse(base64);
                    final token = stringToBase64.encode(rawData);
                    logger.d(token);

                    final resp = await dio.post("$serverIp/auth/login",
                        options: Options(
                            headers: {"authorization": "Basic $token"}));

                    await storage.write(
                        key: ACCESS_TOKEN, value: resp.data["accessToken"]);
                    await storage.write(
                        key: REFRESH_TOKEN, value: resp.data["refreshToken"]);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const RootTap()),
                        (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                      foregroundColor: Colors.white),
                  child: const Text("로그인"),
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
  const _Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      "환영합니다.",
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      "이메일과 비밀번호를 입력해서 로그인해주세요\n성공적인 주문이 되실길... :)",
      style: TextStyle(color: BODY_TEXT_COLOR),
    );
  }
}
