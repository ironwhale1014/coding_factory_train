import 'package:coding_factory_train/common/const/color.dart';
import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:coding_factory_train/common/secure/secure_storage.dart';
import 'package:coding_factory_train/common/util/logger.dart';
import 'package:coding_factory_train/common/view/root_tap.dart';
import 'package:coding_factory_train/user/view/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    checkToken();
    super.initState();
  }

  void checkToken() async {
    logger.d("checkToken");
    final FlutterSecureStorage flutterSecureStorage =
        ref.read(flutterSecureStorageProvider);
    final refreshToken = await flutterSecureStorage.read(key: REFRESH_TOKEN);
    final Dio dio = Dio();

    try {
      final response = await dio.post("$serverUrl/auth/token",
          options: Options(headers: {"authorization": "Bearer $refreshToken"}));
      final accessToken = response.data["accessToken"];
      await flutterSecureStorage.write(key: ACCESS_TOKEN, value: accessToken);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const RootTap()), (root) => false);
    } catch (e) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (root) => false);
    }
  }

  void deleteToken() {
    final FlutterSecureStorage flutterSecureStorage =
        ref.read(flutterSecureStorageProvider);
    flutterSecureStorage.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultLayout(
        backgroundColor: PRIMATY_COLOR,
        child: SizedBox(
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
              ),
            ],
          ),
        ));
  }
}
