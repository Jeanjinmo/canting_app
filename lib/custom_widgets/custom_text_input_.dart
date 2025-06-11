import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintText;
  final String? prefixText;
  final bool? obsecureText;
  final Widget? suffixIcon;

  const CustomTextInput({
    super.key,
    required this.controller,
    required this.textInputType,
    required this.hintText,
    this.prefixText,
    this.obsecureText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: obsecureText ?? false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        hintText: hintText,
        prefixText: prefixText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
