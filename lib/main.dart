import 'package:coding_factory_train/common/component/custom_textformfield.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(_App());
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
                hintText: "input email", onChanged: (String value) {}),
            CustomTextFormField(
                hintText: "input password",
                onChanged: (String value) {},
                obscureText: true)
          ],
        ),
      ),
    );
  }
}
