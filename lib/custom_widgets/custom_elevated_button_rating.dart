import 'package:flutter/material.dart';

class CustomElevatedButtonRating extends StatelessWidget {
  final void Function() onPressed;
  final String ratingText;
  const CustomElevatedButtonRating({
    super.key,
    required this.onPressed,
    required this.ratingText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: Colors.amber),
          Text(
            ratingText,
            style: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
