import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FileControl extends StatelessWidget {
  const FileControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        height: 60.0.h,
        decoration: BoxDecoration(
            color: AppColors.backgroundColorSec(context),
            borderRadius: BorderRadius.circular(8.0)),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
              height: 40.0.h,
              width: 150.0.w,
              decoration: BoxDecoration(
                  color: AppColors.commentColor(context),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Center(
                  child: Text(
                "Agregar archivos...",
                style: AppTextStyle(context)
                    .bold14(color: Colors.white, fontWeight: FontWeight.w600),
              ))),
        ));
  }
}
