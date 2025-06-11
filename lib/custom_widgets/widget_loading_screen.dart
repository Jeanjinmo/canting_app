import 'package:flutter/material.dart';

class WidgetLoadingScreen extends StatelessWidget {
  const WidgetLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
