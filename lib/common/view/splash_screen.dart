import 'package:coding_factory_train/common/const/colors.dart';
import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  static String get routeName => "splash";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return DefaultLayout(
        backgroundColor: PRIMARY_COLOR,
        child: SizedBox(
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "asset/img/logo/logo.png",
                width: size.width / 2,
              ),
              const CircularProgressIndicator(color: Colors.white)
            ],
          ),
        ));
  }
}
