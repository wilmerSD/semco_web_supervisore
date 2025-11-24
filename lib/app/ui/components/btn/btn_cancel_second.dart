import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class BtnCancelSecond extends StatelessWidget {
  const BtnCancelSecond(
      {super.key,
      required this.text,
      this.onTap,
      this.borderColor,
      this.textColor});
  final String text;
  final void Function()? onTap;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43.0,
      decoration: BoxDecoration(
          // color: Colors.transparent,
          color: AppColors.backgroundColor(context),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: borderColor ?? AppColors.primary(context), width: 1)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: const Color.fromRGBO(0, 0, 0, 0.08),
          borderRadius: BorderRadius.circular(8.0),
          onTap: onTap,
          child: Center(
            child: Text(text,
                style: AppTextStyle(context).bold14(
                        color: AppColors.primary(context),
                        fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}
