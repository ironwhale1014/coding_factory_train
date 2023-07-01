import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;

  Color? backgroundColor;

  DefaultLayout({super.key, required this.child, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      body: child,
    );
  }
}
