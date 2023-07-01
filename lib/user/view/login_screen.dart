import 'dart:convert';
import 'dart:io';

import 'package:coding_factory_train/common/component/custom_textformfield.dart';
import 'package:coding_factory_train/common/const/colors.dart';
import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:coding_factory_train/common/view/root_tap.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final simulIp = "http://127.0.0.1:3000";
    final emulIp = "http://10.0.2.2:3000";

    final ip = Platform.isIOS ? simulIp : emulIp;
    final dio = Dio();



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
                onPressed: () async {
                  final rawString = '$username:$password';

                  Codec<String, String> stringToBase64 = utf8.fuse(base64);

                  String token = stringToBase64.encode(rawString);
                  print("http://$ip/auth/login");

                  final resp = await dio.post("$ip/auth/login",
                      options:
                          Options(headers: {'Authorization': 'Basic $token'}));

                  String accessToken = resp.data["accessToken"];
                  String refreshToken = resp.data["refreshToken"];

                  await storage.write(key: ACCESS_TOKEN, value: accessToken);
                  await storage.write(key: REFRESH_TOKEN, value: refreshToken);

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => RootTap()));
                },
                style: ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR),
                child: const Text("로그인"),
              ),
              TextButton(
                  onPressed: () async {
                    String refreshToken =
                        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoicmVmcmVzaCIsImlhdCI6MTY4ODIwNDI0OCwiZXhwIjoxNjg4MjkwNjQ4fQ.d52N5mJkpSQVZTXAvMPiAkOLUOLT76Sg6nnSbtrBQSE";

                    final resp = await dio.post("$ip/auth/token",
                        options: Options(headers: {
                          'Authorization': 'Bearer $refreshToken'
                        }));

                    print(resp.data);
                  },
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
