import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomFilterChat extends StatelessWidget {
  final int option;
  final int lastOption;
  final int? maxLines;
  final String optionText;
  const CustomFilterChat(
      {super.key,
      required this.option,
      required this.lastOption,
      required this.optionText,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
      padding: option != lastOption
          ? const EdgeInsets.all(5.0)
          : const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: option == lastOption
              ? AppColors.menuSelectedColor(context)
              : const Color.fromARGB(255, 166, 169, 170),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Text(optionText,
              style: TextStyle(
                  color: option != lastOption
                      ? AppColors.textBasic(context)
                      : Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 15.0)),
        ],
      ),
    );
  }
}
