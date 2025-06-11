import 'package:flutter/material.dart';

class WidgetErrorMessage extends StatelessWidget {
  const WidgetErrorMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
