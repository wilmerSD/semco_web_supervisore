import 'package:flutter/material.dart';

class RotatingIcon extends StatelessWidget {
  final bool expanded;
  final IconData icon;
  final Duration duration;
  final double size;
  final Color? color;

  const RotatingIcon({
    super.key,
    required this.expanded,
    required this.icon,
    this.duration = const Duration(milliseconds: 500),
    this.size = 15.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: expanded ? 0.5 : 0.0, // 🔁 rota 180°
      duration: duration,
      curve: Curves.easeInOut,
      child: Icon(
        icon,
        size: size,
        color: color ?? Theme.of(context).iconTheme.color,
      ),
    );
  }
}
