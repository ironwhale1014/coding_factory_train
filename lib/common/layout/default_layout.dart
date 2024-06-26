import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  const DefaultLayout(
      {super.key, required this.child, this.backgroundColor = Colors.white, this.bottomNavigationBar});

  final Widget child;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      body: child,
    );
  }
}
