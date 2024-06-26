import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RootTap extends ConsumerStatefulWidget {
  const RootTap({super.key});

  @override
  ConsumerState createState() => _RootTapState();
}

class _RootTapState extends ConsumerState<RootTap>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController controller;

  final List<NavigationDestination> _taps = [
    const NavigationDestination(icon: Icon(Icons.home), label: "home"),
    const NavigationDestination(
        icon: Icon(Icons.fastfood_outlined), label: "food"),
    const NavigationDestination(icon: Icon(Icons.receipt_long), label: "order"),
    const NavigationDestination(
        icon: Icon(Icons.person_2_outlined), label: "profile"),
  ];

  final List<Widget> _screens = [
    Container(color: Colors.red),
    Container(color: Colors.green),
    Container(color: Colors.blue),
    Container(color: Colors.purple),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabBarListener);
  }

  void tabBarListener() {
    setState(() {
      _selectedIndex = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            controller.animateTo(index);
          },
          destinations: _taps,
        ),
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: _screens,
        ));
  }
}
