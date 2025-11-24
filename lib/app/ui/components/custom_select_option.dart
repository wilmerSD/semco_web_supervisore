import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSelectOption extends StatelessWidget {
  final int option;
  final int lastOption;
  final int? maxLines;
  final String optionText;
  const CustomSelectOption(
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
          ? const EdgeInsets.all(3.0)
          : const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: option == lastOption
              ? AppColors.menuSelectedColor(context)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          const Icon(
            Icons.business_center,
            color: Colors.white,
            size: 16.0,
          ),
          SizedBox(
            width: 3.0.w,
          ),
          Text(optionText,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp)),
        ],
      ),
    );
  }
}
