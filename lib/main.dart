import 'package:coding_factory_train/user/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _APP(),
      theme: ThemeData(
        fontFamily: "NotoSans",
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)),
    ),
  ));
}

class _APP extends StatelessWidget {
  const _APP({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
