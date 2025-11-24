import 'package:app_tasking/core/helpers/constant.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class BtnCancelThird extends StatelessWidget {
  const BtnCancelThird({
    super.key,
    required this.text,
    this.loading = false,
    this.onTap,
    this.isGreen = false,
    this.margin,
    this.showBoxShadow = true,
    this.icon,
  });
  final IconData? icon;
  final String text;
  final bool loading;
  final bool? isGreen;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final bool showBoxShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryConst),
        borderRadius: BorderRadius.circular(kRadiusMin),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8.0,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    size: 18,
                    color: AppColors.primaryConst,
                  ),
                Text(
                  textScaler: const TextScaler.linear(1.0),
                  text,
                  style: AppTextStyle(context).bold15(
                      color: AppColors.primaryConst,
                      fontWeight: FontWeight.w200),
                ),
                if (loading)
                  const Row(
                    children: [
                      SizedBox(
                        width: 30.0,
                      ),
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
