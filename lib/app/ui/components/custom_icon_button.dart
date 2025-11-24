import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData iconData;
  final double? size;
  final Color? color;
  const CustomIconButton(
      {super.key,
      this.onPressed,
      required this.iconData,
      this.size = 15.0,
      this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed, icon: Icon(iconData, size: size, color: color));
  }
}
