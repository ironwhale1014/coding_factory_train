import 'package:flutter/material.dart';

void main() {
  _App();
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, fontFamily: 'NotoSans'),
      debugShowCheckedModeBanner: false,
      home: Container(),
    );
  }
}
