import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class RootTap extends StatefulWidget {
  const RootTap({super.key});

  @override
  State<RootTap> createState() => _RootTapState();
}

class _RootTapState extends State<RootTap> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tapListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }


  void tapListener(){
    setState(() {
      selectedIndex = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: "코드 딜리버리",
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (int index) {
            controller.animateTo(index);
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: "홈"),
            NavigationDestination(
                icon: Icon(Icons.fastfood_outlined), label: "음식"),
            NavigationDestination(
                icon: Icon(Icons.receipt_long_outlined), label: "주문"),
            NavigationDestination(
                icon: Icon(Icons.person_outline), label: "프로필"),
          ],
        ),
        child: TabBarView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            Center(child: Text("홈")),
            Center(child: Text("음식")),
            Center(child: Text("주문")),
            Center(child: Text("프로필")),
          ],
        ));
  }
}
