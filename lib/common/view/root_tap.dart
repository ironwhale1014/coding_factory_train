import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class RootTap extends StatelessWidget {
  const RootTap({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Center(child: Text("root tap")),
    );
  }
}
