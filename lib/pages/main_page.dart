import 'package:canting_app/pages/home_page.dart';
import 'package:canting_app/pages/order_page.dart';
import 'package:canting_app/pages/profile_page.dart';
import 'package:canting_app/provider/index_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            0 => const HomePage(),
            1 => const OrderPage(),
            _ => const ProfilePage(),
          };
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
        onDestinationSelected: (index) =>
            context.read<IndexNavProvider>().updateIndexBottomNavBar(index),
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
            tooltip: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.description_outlined),
            label: "Orders",
            tooltip: "Orders",
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profile",
            tooltip: "Profile",
          ),
        ],
      ),
    );
  }

  // BottomNavigationBar _bottomNavBarSimple(BuildContext context) {
  //   return BottomNavigationBar(
  //     currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
  //     onTap: (index) {
  //       context.read<IndexNavProvider>().updateIndexBottomNavBar(index);
  //     },
  //     items: [
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.home),
  //         label: "Home",
  //         tooltip: "Home",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.description),
  //         label: "Orders",
  //         tooltip: "Orders",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.person),
  //         label: "Profile",
  //         tooltip: "Profile",
  //       ),
  //     ],
  //   );
  // }
}
