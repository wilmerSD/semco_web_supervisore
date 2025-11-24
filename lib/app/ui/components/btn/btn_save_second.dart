import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BtnSaveSecond extends StatelessWidget {
  const BtnSaveSecond({
    super.key,
    required this.text,
    this.loading = false,
    this.onTap,
    this.isGreen = false,
    this.margin,
    this.showBoxShadow = true,
  });
  final String text;
  final bool loading;
  final bool? isGreen;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final bool showBoxShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43.0,
      margin: margin,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(8.0.r),
        // boxShadow: showBoxShadow
        //     ? [
        //         BoxShadow(
        //           color: AppColors.primary(context).withValues(),
        //           spreadRadius: 5,
        //           blurRadius: 20,
        //           offset: const Offset(0, 4),
        //         ),
        //       ]
        //     : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: loading ? null : onTap,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textScaler: const TextScaler.linear(1.0),
                  text,
                  style: AppTextStyle(context).bold14(
                        color: Colors.white, fontWeight: FontWeight.w600),
                ),
                if (loading)
                     const Row(
                        children: [
                          SizedBox(
                            width: 30.0,
                          ),
                          SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
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
