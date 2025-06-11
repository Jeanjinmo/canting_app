import 'package:flutter/material.dart';

class CustomProfileListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String startText;
  final String? endText;
  final Widget trailing;
  final void Function()? onTap;

  const CustomProfileListTile({
    super.key,
    required this.leadingIcon,
    required this.startText,
    this.endText,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.0),
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
        leading: Icon(leadingIcon),
        title: Row(children: [Text(startText), Spacer(), Text(endText ?? "")]),
        trailing: trailing,
      ),
    );
  }
}
