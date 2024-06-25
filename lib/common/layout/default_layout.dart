import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  const DefaultLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: child,
    );
  }
}
