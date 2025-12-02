import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAnimatedSwicher extends StatefulWidget {
  final Widget option1;
  final Widget option2;

  const CustomAnimatedSwicher({
    super.key,
    required this.option1,
    required this.option2,
  });

  @override
  State<CustomAnimatedSwicher> createState() => _CustomAnimatedSwicherState();
}

class _CustomAnimatedSwicherState extends State<CustomAnimatedSwicher> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // necesito que vaya al centro
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _tabButton("Acuerdos", 0),
            const SizedBox(width: 10),
            _tabButton("Notas", 1),
          ],
        ),
        const SizedBox(height: 15),

        // ⭐ CAMBIO REAL AQUÍ
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          child: selectedIndex == 0 ? widget.option1 : widget.option2,
        ),
      ],
    );
  }

  Widget _tabButton(String text, int index) {
    final isActive = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryConst : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
