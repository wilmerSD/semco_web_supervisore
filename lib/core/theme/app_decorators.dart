import 'package:app_tasking/core/helpers/constant.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class AppDecorators {
  static InputDecoration inputDecorationGen(BuildContext context,
      String hintText, String labelText, Widget? suffixIcon, bool isMandatory) {
    return InputDecoration(
      label: RichText(
        text: TextSpan(
          text: labelText,
          style: TextStyle(color: Colors.grey[700]),
          children: isMandatory
              ? const [
                  WidgetSpan(
                    child: SizedBox(width: 5),
                  ),
                  TextSpan(
                    text: "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ]
              : null,
        ),
      ),
      suffixIcon: suffixIcon,
      counterText: "",
      filled: false,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 12.0,
      ),
      //floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIconColor: AppColors.primary(context),
      floatingLabelStyle: AppTextStyle(context).medium14(
        color: AppColors.grayBlue,
      ),
      labelStyle: AppTextStyle(context).medium14(
        color: AppColors.grayBlue,
      ),
      hintText: hintText,
      hintStyle: AppTextStyle(context).medium14(
        color: AppColors.grayBlue,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kSizeLittle),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kSizeLittle),
        borderSide: const BorderSide(
          width: 1.0,
          color: AppColors.grayLight,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kSizeLittle),
        borderSide: BorderSide(
          width: .5,
          color: AppColors.primary(context),
        ),
      ),
    );
  }

  static InputDecoration inputDecorationComboBox(BuildContext context,
      String hintText, String labelText, Widget? suffixIcon, bool isMandatory) {
    return InputDecoration(
      label: RichText(
        text: TextSpan(
          text: labelText,
          style: TextStyle(color: Colors.grey[700]),
          children: isMandatory
              ? const [
                  WidgetSpan(
                    child: SizedBox(width: 5),
                  ),
                  TextSpan(
                    text: "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ]
              : null,
        ),
      ),
      suffixIcon: suffixIcon,
      counterText: "",
      filled: false,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 11.0,
      ),
      //floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIconColor: AppColors.primary(context),
      floatingLabelStyle: AppTextStyle(context).medium14(
        color: AppColors.grayBlue,
      ),
      labelStyle: AppTextStyle(context).medium14(
        color: AppColors.grayBlue,
      ),
      hintText: hintText,
      hintStyle: AppTextStyle(context).medium14(
        color: AppColors.textBasic(context),
      ),
      // labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kSizeLittle),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kSizeLittle),
        borderSide: const BorderSide(
          width: 1.0,
          color: AppColors.grayLight,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kSizeLittle),
        borderSide: BorderSide(
          width: .5,
          color: AppColors.primary(context),
        ),
      ),
    );
  }
}
