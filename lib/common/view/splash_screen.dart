import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/dio/dio.dart';
import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:coding_factory_train/common/secure/secure_storage.dart';
import 'package:coding_factory_train/common/view/root_tap.dart';
import 'package:coding_factory_train/user/view/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkToken();
  }

  Future<void> checkToken() async {
    final storage = ref.read(secureStorageProvider);
    final refreshToken = await storage.read(key: REFRESH_TOKEN);
    final dio = ref.read(dioProvider);

    try {
      final resp = await dio.post("$serverIp/auth/token",
          options: Options(headers: {"authorization": "Bearer $refreshToken"}));

      final accessToken = resp.data[ACCESS_TOKEN];
      await storage.write(key: ACCESS_TOKEN, value: accessToken);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => RootTap()), (route) => false);
    } catch (e) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultLayout(
        backgroundColor: PRIMARY_COLOR,
        body: SizedBox(
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "asset/img/logo/logo.png",
                width: size.width / 2,
              ),
              const SizedBox(height: 16),
              const CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ));
  }
}
