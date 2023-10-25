import 'package:coding_factory_train/common/const/colors.dart';
import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:coding_factory_train/product/view/product_screen.dart';
import 'package:coding_factory_train/restaurant/view/restaurant_screen.dart';
import 'package:flutter/material.dart';

class RootTap extends StatefulWidget {
  const RootTap({super.key});
  static String get routeName => "rootTap";

  @override
  State<RootTap> createState() => _RootTapState();
}

class _RootTapState extends State<RootTap> with SingleTickerProviderStateMixin {
  int index = 0;

  late TabController controller;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.removeListener(tabListener);
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "코드 딜리버리",
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.shifting,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "홈"),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood_outlined), label: "음식"),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined), label: "주문"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "프로필"),
        ],
      ),
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: const [
          RestaurantScreen(),
          ProductScreen(),
          Center(child: Text("주문")),
          Center(child: Text("프로필")),
        ],
      ),
    );
  }
}
