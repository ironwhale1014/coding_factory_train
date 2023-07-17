import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final String? title;
  final Widget child;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;

  DefaultLayout(
      {super.key,
      this.title,
      required this.child,
      this.actions,
      this.bottomNavigationBar,
      this.floatingActionButton,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppbar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      backgroundColor: backgroundColor ?? Colors.white,
    );
  }

  AppBar? renderAppbar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(title!),
        actions: actions,
      );
    }
  }
}
