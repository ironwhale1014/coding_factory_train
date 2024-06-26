import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  const DefaultLayout(
      {super.key, required this.child, this.backgroundColor = Colors.white});

  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: child,
    );
  }
}
