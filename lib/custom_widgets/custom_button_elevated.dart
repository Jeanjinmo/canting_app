import 'package:flutter/material.dart';

class CustomButtonElevated extends StatelessWidget {
  final void Function() onPressed;
  final String imageSource;
  final String nameButton;
  const CustomButtonElevated({
    super.key,
    required this.onPressed,
    required this.imageSource,
    required this.nameButton,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12.0),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(height: 30, imageSource, fit: BoxFit.cover),
            const SizedBox(width: 8),
            Text(nameButton),
          ],
        ),
      ),
    );
  }
}
