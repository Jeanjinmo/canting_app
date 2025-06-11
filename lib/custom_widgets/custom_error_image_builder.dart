import 'package:flutter/material.dart';

class CustomErrorImageBuilder extends StatelessWidget {
  final Widget? iconError;
  const CustomErrorImageBuilder({super.key, required this.iconError});

  const CustomErrorImageBuilder.noIcon({super.key, this.iconError});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconError ?? Icon(Icons.error),
          const SizedBox(height: 2.0),
          Text('Gambar gagal dimuat'),
        ],
      ),
    );
  }
}
