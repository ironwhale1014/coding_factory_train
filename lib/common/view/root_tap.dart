import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:coding_factory_train/restaurant/view/restaurant_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RootTap extends ConsumerStatefulWidget {
  const RootTap({super.key});

  @override
  ConsumerState createState() => _RootTapState();
}

class _RootTapState extends ConsumerState<RootTap>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(listener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  void listener() {
    setState(() {
      selectedIndex = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: const [
          RestaurantScreen(),
          Center(child: Text("food")),
          Center(child: Text("order")),
          Center(child: Text("profile")),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          controller.animateTo(index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: "home"),
          NavigationDestination(
              icon: Icon(Icons.fastfood_outlined), label: "food"),
          NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined), label: "order"),
          NavigationDestination(
              icon: Icon(Icons.person_outline), label: "profile"),
        ],
      ),
    );
  }
}
