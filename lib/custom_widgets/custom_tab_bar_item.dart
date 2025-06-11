import 'package:flutter/material.dart';

class CustomTabBarItem extends StatelessWidget {
  final TabController? tabController;
  final List<Tab> tab;
  final void Function(int index) onTap;
  const CustomTabBarItem({
    super.key,
    required this.tab,
    required this.onTap,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.5),
        color: Theme.of(context).colorScheme.surfaceContainerLow,
      ),
      child: TabBar(
        controller: tabController,
        onTap: onTap,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12.5),
          color: Theme.of(context).primaryColor,
        ),
        labelColor: Theme.of(context).colorScheme.onPrimary,
        unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
        tabs: tab,
      ),
    );
  }
}
