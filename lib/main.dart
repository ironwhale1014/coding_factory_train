import 'package:coding_factory_train/common/component/custom_textformfield.dart';
import 'package:coding_factory_train/common/view/splash_screen.dart';
import 'package:coding_factory_train/user/view/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(_App());
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, fontFamily: 'NotoSans'),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
